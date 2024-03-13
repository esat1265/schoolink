class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :check_access, only: [:show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
  end

  def index
    if current_user.type == "Teacher"
      # Trouver tous les étudiants associés à cet enseignant à travers les cours.
      students = Student.joins(:courses).where(courses: {teacher_id: current_user.id}).distinct
      # En utilisant les étudiants, trouver les parents uniques et trier par section puis par last_name des parents
      @parents = students.map(&:parent).compact.uniq.sort_by { |parent| [parent.student.section_id, parent.last_name] }
      if params[:search].present?
        search_term = "%#{params[:search]}%"
        @parents = students.map(&:parent).uniq.compact
      end
    elsif current_user.type == "Parent"
      student = current_user.student
      @teachers = student.courses.map(&:teacher).uniq if student
    end
  end


  def find_or_create
    teacher_id = params[:teacher_id]
    parent_id = params[:parent_id] || current_user.id

    chatroom = Chatroom.find_or_create_by(teacher_id: teacher_id, parent_id: parent_id)
    redirect_to chatroom
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def check_access
    unless current_user == @chatroom.parent || current_user == @chatroom.teacher
      redirect_to chatrooms_path, alert: "Vous n'avez pas l'accès à cette chatroom."
    end
  end
end

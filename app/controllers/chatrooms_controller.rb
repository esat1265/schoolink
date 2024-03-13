class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :check_access, only: [:show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
    @chatroom.messages.where.not(user_id: current_user.id).update_all(read: true)
  end

  def index
    if current_user.type == "Teacher"
      students = Student.joins(:courses).where(courses: { teacher_id: current_user.id }).distinct
      @parent_data = students.map do |student|
        parent = student.parent
        next unless parent
        unread_messages = Chatroom.where(teacher_id: current_user.id, parent_id: parent.id).any? { |chatroom| chatroom.messages.where.not(user_id: current_user.id).where(read: false).exists? }
        { parent: parent, unread_messages: unread_messages }
      end.compact
    elsif current_user.type == "Parent"
      student = current_user.student
      if student
        unique_teachers = student.courses.includes(:teacher).map(&:teacher).uniq
        @teacher_data = unique_teachers.map do |teacher|
          unread_messages = Chatroom.where(teacher_id: teacher.id, parent_id: current_user.id).joins(:messages).where(messages: {read: false, user_id: teacher.id}).exists?
          { teacher: teacher, unread_messages: unread_messages }
        end
      end
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

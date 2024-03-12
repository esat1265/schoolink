class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :check_access, only: [:show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
  end

  def index
    if current_user.type == "Teacher" && current_user.sections.any?
      @chatrooms = Chatroom.where(teacher: current_user)
      @parents = current_user.sections.map(&:students).flatten.map(&:parent).uniq
    elsif current_user.type == "Parent"
      @chatrooms = Chatroom.where(parent: current_user)
      @teachers = current_user.student.courses.map(&:teacher).uniq
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

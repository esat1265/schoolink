class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
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

  def create

  end
end

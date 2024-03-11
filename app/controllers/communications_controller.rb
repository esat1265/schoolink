class CommunicationsController < ApplicationController
  before_action :set_recipients, only: [:new, :create]

  def index
    @sent_communications = current_user.sent_communications.includes(:receiver)
    @received_communications = current_user.received_communications.includes(:sender)
  end

  def new
    @communication = Communication.new
  end

  def create
    @communication = current_user.sent_communications.build(communication_params)
    if @communication.save
      redirect_to communications_path, notice: 'Your message was successfully sent.'
    else
      render :new
    end
  end

  private

  def set_recipients
    if current_user.type == "Teacher"
      @recipients = User.joins(students: :section).where(sections: { id: current_user.courses.select(:section_id) }).where(type: 'Parent').distinct
    elsif current_user.type == "Parent"
      # Pour les parents, récupérez les enseignants des cours auxquels les enfants du parent sont inscrits.
      # Assurez-vous que vous avez une méthode ou une association `students` pour récupérer les enfants d'un parent.
      @recipients = User.joins(courses: :section).where(sections: { id: current_user.students.select(:section_id) }).where(type: 'Teacher').distinct
    end

  end

  def communication_params
    params.require(:communication).permit(:receiver_id, :body)
  end
end

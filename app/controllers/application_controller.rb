class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_unread_messages_count

  private

  def set_unread_messages_count
    if current_user
      # Remplacer cette ligne avec la logique appropriée pour votre modèle
      # Par exemple, si chaque utilisateur a des chatrooms :
      @unread_messages_count = Message.joins(:chatroom)
                                      .where(chatrooms: {parent_id: current_user.id})
                                      .or(Message.joins(:chatroom).where(chatrooms: {teacher_id: current_user.id}))
                                      .where(read: false)
                                      .count
    end
  end
end

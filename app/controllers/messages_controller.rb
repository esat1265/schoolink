
class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.new(message_params)
    @message.user = current_user


    if @message.save
      redirect_to @chatroom
    else
      render 'chatrooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

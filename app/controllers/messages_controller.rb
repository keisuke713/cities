class MessagesController < ApplicationController
  def index
    @users = current_user.communicated_users
  end

  def create
    message = current_user.send_messages.build(message_params)

    if message.save
      flash[:success] = 'succeeded in sending message'
      redirect_to user_message_path(current_user.id, message_params[:receiver_id])
    else
      flash.now[:danger] = 'failed  to send message'
      render 'show'
    end
  end

  def show
    @messages = Message.messages_with(current_user.id, params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:content, :receiver_id)
  end
end

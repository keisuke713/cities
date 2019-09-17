class MessagesController < ApplicationController
  before_action :logged_in_user

  def index
    @users = Message.sender_and_receiver(current_user)
  end

  def create
    message = current_user.send_messages.build(message_params)

    if message.save
      flash[:success] = 'succeeded in sending message'
      redirect_to user_message_path(current_user.id, message_params[:receiver_id])
    else
      flash[:danger] = 'failed  to send message'
      render 'show'
    end
  end

  def show
    @message = Message.new
    @messages = Message.all_messages(current_user.id, params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:content, :receiver_id)
  end
end

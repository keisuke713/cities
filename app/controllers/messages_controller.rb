class MessagesController < ApplicationController
  before_action :logged_in_user

  def index
    @users = Message.sender_and_receiver(current_user)
  end

  def create
  end

  def show
  end
end

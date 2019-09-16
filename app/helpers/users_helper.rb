module UsersHelper
  def user
    User.find(params[:id])
  end

  def edit_user_link(user)
    render 'shared/edit_user_link' if current_user == user
  end

  def delete_user_link(user)
    link_to "削除", user_path(user), method: :delete, data: { confirm: "You sure" } if current_user.admin? && !current_user?(user)
  end

  def image(user)
    image_tag user.image.thumb30.url if user.image?
  end

  def send_message_link(user_id, other_user_id)
    link_to 'メッセージを送る', user_message_path(user_id, other_user_id) unless user_id == other_user_id
  end
end

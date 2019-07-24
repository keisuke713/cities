module UsersHelper
  def user
    User.find(params[:id])
  end

  def edit_user_link(user)
    render 'shared/edit_user_link' if current_user == user
  end

  def image(user)
    image_tag user.image.thumb30.url if user.image?
  end
end

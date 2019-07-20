module UsersHelper
  def edit_user_link(user)
    render 'shared/edit_user_link' if current_user == user
  end
end

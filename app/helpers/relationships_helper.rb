module RelationshipsHelper
  def follow_or_unfollow_link(user, other_user)
    return if user.id == other_user.id
    if Relationship.check(user, other_user)
      link_to 'unfollow', '#'
    else
      link_to 'follow', user_relationships_path(@user.id), method: :post
    end
  end
end

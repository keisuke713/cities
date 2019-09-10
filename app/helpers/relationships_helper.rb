module RelationshipsHelper
  def follow_or_unfollow_link(user, other_user)
    return if user.id == other_user.id
    if @relationship.nil?
      link_to 'follow', user_relationships_path(@user.id), method: :post
    else
      link_to 'unfollow', user_relationship_path(@user.id, @relationship.id), method: :delete
    end
  end
end

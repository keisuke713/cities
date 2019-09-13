module RelationshipsHelper
  def follow_or_unfollow_link(user_id, other_user_id, relationship_id)
    return if user_id == other_user_id
    if relationship_id.nil?
      link_to 'follow', user_relationships_path(other_user_id), method: :post
    else
      link_to 'unfollow', user_relationship_path(other_user_id, relationship_id), method: :delete
    end
  end
end

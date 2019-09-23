class AddParentPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :parent, foreign_key: { to_table: :posts }
  end
end

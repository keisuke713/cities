class ChangeColumnToPostImage < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :image, :string, null: true
  end
end

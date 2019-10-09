class AddDefaultToPost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :draft_status, :integer, default: 0
  end
end

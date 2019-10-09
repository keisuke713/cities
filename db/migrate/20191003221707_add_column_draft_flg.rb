class AddColumnDraftFlg < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :draft_status, :integer
  end
end

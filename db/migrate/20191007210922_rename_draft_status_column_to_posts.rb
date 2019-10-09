class RenameDraftStatusColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :draft_status, :status
  end
end

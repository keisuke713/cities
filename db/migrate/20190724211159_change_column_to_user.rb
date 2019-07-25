class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :intro, false
    change_column_null :users, :password_digest, false
  end
end

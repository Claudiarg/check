class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :auth_token, :string
  end
end

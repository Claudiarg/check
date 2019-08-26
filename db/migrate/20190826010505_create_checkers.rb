class CreateCheckers < ActiveRecord::Migration[5.2]
  def change
    create_table :checkers do |t|
      t.datetime :checkin
      t.datetime :checkout
      t.references :user
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :checkers, :deleted_at
  end
end

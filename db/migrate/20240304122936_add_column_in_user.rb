class AddColumnInUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :integer
    add_reference :users, :parent, foreign_key: { to_table: :users }
  end
end

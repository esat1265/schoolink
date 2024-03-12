class AddForeignKeyToChatroom < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :parent, foreign_key: { to_table: :users }
    add_reference :chatrooms, :teacher, foreign_key: { to_table: :users }
  end
end

class DropTableChatroom < ActiveRecord::Migration[7.1]
  def change
    drop_table :communications
  end
end

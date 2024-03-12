class DropTableChatrooms < ActiveRecord::Migration[7.1]
  def change
    drop_table :chatrooms
  end
end

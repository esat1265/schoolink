class AddSectionToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :section
  end
end

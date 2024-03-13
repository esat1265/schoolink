class AddColumnImageOnGrades < ActiveRecord::Migration[7.1]
  def change
    add_column :grades, :photo, :string
  end
end

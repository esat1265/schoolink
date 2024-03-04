class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.references :course, null: false, foreign_key: true
      t.decimal :grade
      t.date :date
      t.string :exam_name
      t.text :comment
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

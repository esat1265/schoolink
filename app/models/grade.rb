class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates :grade, presence: true
  validates :date, presence: true
  validates :exam_name, presence: true
end

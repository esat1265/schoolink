class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student
  # has_one_attached :photo

  validates :grade, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
  validates :student, uniqueness: { scope: [:course_id, :exam_name], message: "should have only one grade per exam per course" }
  validates :date, presence: true
  validates :exam_name, presence: true
  validate :exam_date_cannot_be_in_the_future

  def exam_date_cannot_be_in_the_future
    errors.add(:date, "can't be in the future") if date.present? && date > Date.today
  end
end

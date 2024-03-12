class Teacher < User
  has_many :courses, foreign_key: "teacher_id"
  has_many :sections, -> { distinct }, through: :courses
  has_many :grades
  has_many :students
  has_many :chatrooms, foreign_key: "teacher_id"
end

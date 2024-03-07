class Teacher < User
  has_many :courses
  has_many :sections, -> { distinct }, through: :courses
  has_many :grades
  has_many :students
end

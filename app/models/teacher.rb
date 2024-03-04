class Teacher < User
  has_many :courses
  has_many :sections
  has_many :grades
  has_many :students
end

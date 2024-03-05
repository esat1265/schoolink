class Student < User
  belongs_to :parent
  belongs_to :section
  has_many :grades
  has_many :courses
end

class Student < User
  belongs_to :parent, class_name: 'User', optional: true
  belongs_to :section
  has_many :grades
  has_many :courses
end

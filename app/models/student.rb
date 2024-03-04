class Student < User
  belongs_to :parent
  belongs_to :section
  has_many :grades
  has_many :courses

  validates :parent_id, presence: true
  validates :section_id, presence: true
end

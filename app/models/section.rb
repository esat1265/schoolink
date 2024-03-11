class Section < ApplicationRecord
  has_many :courses
  has_many :teachers, through: :courses
  has_many :students, -> { where(type: 'Student') }, class_name: 'User', foreign_key: 'section_id'
  has_many :users
  validates :name, presence: true
end

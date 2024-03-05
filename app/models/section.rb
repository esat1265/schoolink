class Section < ApplicationRecord
  has_many :courses
  has_many :students

  validates :name, presence: true
end

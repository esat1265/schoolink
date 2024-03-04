class Course < ApplicationRecord
  belongs_to :section
  belongs_to :teacher, foreign_key: 'user_id'

  validates :name, presence: true
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :type, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  belongs_to :section, optional: true
  has_many :courses, foreign_key: 'teacher_id'
  belongs_to :section, optional: true
end

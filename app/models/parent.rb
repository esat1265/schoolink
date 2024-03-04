class Parent < User
  has_many :students

  validates :phone_number, presence: true
end

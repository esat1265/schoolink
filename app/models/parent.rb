class Parent < User
  has_one :student

  validates :phone_number, presence: true
end

class Parent < User
  has_one :student
  validates :phone_number, presence: true
  has_many :sent_communications, foreign_key: :sender_id, class_name: 'Communication'
  has_many :received_communications, foreign_key: :receiver_id, class_name: 'Communication'
end

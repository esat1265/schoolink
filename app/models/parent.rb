class Parent < User
  has_one :student
  validates :phone_number, presence: true
  has_many :sent_messages, foreign_key: :sender_id, class_name: 'Message'
  has_many :received_messages, foreign_key: :receiver_id, class_name: 'Message'
end

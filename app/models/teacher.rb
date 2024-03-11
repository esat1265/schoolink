class Teacher < User
  has_many :courses
  has_many :sections, -> { distinct }, through: :courses
  has_many :grades
  has_many :students
  has_many :sent_communications, foreign_key: :sender_id, class_name: 'Communication'
  has_many :received_communications, foreign_key: :receiver_id, class_name: 'Communication'
end

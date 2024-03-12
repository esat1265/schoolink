class Chatroom < ApplicationRecord
  belongs_to :parent, class_name: "Parent"
  belongs_to :teacher, class_name: "Teacher"
  has_many :messages, dependent: :destroy
end

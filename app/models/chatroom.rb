class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :teacher
  belongs_to :parent
end

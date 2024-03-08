class Message < ApplicationRecord
  belongs_to :chatroom
  has_many :users
  has_many :messages
end

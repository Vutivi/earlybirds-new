class Message < ApplicationRecord
  validates :body, presence: true
  validates :body, length: {minimum: 10, maximum: 350}

  belongs_to :trip
  belongs_to :user
end

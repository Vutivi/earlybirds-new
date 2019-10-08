class Report < ApplicationRecord
  validates :comment, :reason, presence: true
  validates :comment, length: {minimum: 10, maximum: 350}
  
  belongs_to :trip
  belongs_to :user

  enum reason: [
    :scam
  ]
end

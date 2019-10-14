class Lead < ApplicationRecord
  belongs_to :trip

  validates :first_name, :last_name, :cellphone, :email, presence: true
  validates :cellphone, length: {minimum: 10, maximum: 10}
end

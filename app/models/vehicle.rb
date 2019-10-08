class Vehicle < ApplicationRecord

  belongs_to :user
  has_many :trips, dependent: :destroy
  has_one_attached :image

  validates :make, :licence_plate, :model, presence: true
  validate :vehicle_image?


  def vehicle_image?
    errors.add(:base, 'Please upload a picture of your vehicle.') unless image.attached?
  end
end

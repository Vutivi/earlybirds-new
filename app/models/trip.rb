class Trip < ApplicationRecord
  extend FriendlyId
  friendly_id :slugger, use: :slugged
  visitable :ahoy_visit
  
  validates :kind, :start_location, :end_location, :seats, :price, :departure_times, presence: true
  validates :price, length: {minimum: 1, maximum: 4}
  validates_uniqueness_of :kind, scope: %i[vehicle_id start_location departure_times]

  belongs_to :vehicle
  belongs_to :plan
  belongs_to :user
  belongs_to :event, optional: true
  has_many :messages, dependent: :destroy
  has_many :leads,    dependent: :destroy

  enum kind: [
    :social_events,
    :daily_work, 
    :cross_province_home
  ]

  def slugger
    "#{start_location} to #{end_location}"
  end

  def should_generate_new_friendly_id?
    start_location_changed? || end_location_changed?
  end
end

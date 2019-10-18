class Trip < ApplicationRecord
  extend FriendlyId
  include AlgoliaSearch

  algoliasearch do
    attributes :start_location, :end_location, :price, :kind, :event, :slug, :vehicle

    searchableAttributes ['start_location', 'end_location', 'vehicle', 'kind']
    attributesForFaceting ['start_location', 'end_location', 'vehicle', 'kind']
  end

  friendly_id :slugger, use: :slugged
  visitable :ahoy_visit
  
  validates :kind, :start_location, :end_location, :seats, :price, :departure_times, presence: true
  validates :price, length: {minimum: 1, maximum: 4}
  # validates :description, length: {minimum: 10, maximum: 350}
  validates_uniqueness_of :kind, scope: %i[vehicle_id start_location departure_times]
  validate :one_work_trip_per_driver

  belongs_to :vehicle
  belongs_to :plan
  belongs_to :user
  belongs_to :event, optional: true
  has_many :messages, dependent: :destroy
  has_many :leads,    dependent: :destroy
  has_many :riders, dependent: :destroy

  enum kind: [
    :social_events,
    :daily_work, 
    :cross_province_home
  ]

  scope :work_trips_for_user, -> (user_id) { where('kind = ? AND user_id = ?', 1, user_id) }
  scope :events_trips, -> { where.not(event_id: nil) }

  def slugger
    "#{start_location} to #{end_location}"
  end

  def short_start_location
    start_location.split(',')[0]
  end

  def short_end_location
    end_location.split(',')[0]
  end


  def should_generate_new_friendly_id?
    start_location_changed? || end_location_changed?
  end

  private

  def one_work_trip_per_driver
    if kind.eql?('daily_work') && Trip.work_trips_for_user(user_id).present?
      errors.add(:base, 'You can only add one work trip.')
    end
  end
end

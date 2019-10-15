class Rider < ApplicationRecord
  validates :user_id, :trip_id, presence: true
  validates_uniqueness_of :user_id, scope: [:trip_id]
  validate :one_work_trip_per_rider

  belongs_to :user
  belongs_to :trip

  scope :joined_work_trip_for_rider, ->(user_id) { where('user_id = ?', user_id).select {|rider| rider.trip.kind != 1 } }


  private

  def one_work_trip_per_rider
    if Rider.joined_work_trip_for_rider(user_id).present?
      errors.add(:base, 'You already belong to another work trip, Please leave that trip first.')
    end
  end
end

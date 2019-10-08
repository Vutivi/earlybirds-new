class Rider < ApplicationRecord
  validates :user_id, :trip_id, presence: true
  validates_uniqueness_of :user_id, scope: [:trip_id]
  belongs_to :user
  belongs_to :trip
end

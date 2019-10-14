class Event < ApplicationRecord
    include Resizable

    extend FriendlyId
    friendly_id :slugger, use: :slugged

    validates :name, :start_time, :end_time, :address, :description, presence: true
    
    has_many :trips, dependent: :destroy
    has_one_attached :image

    validate :event_image?

    belongs_to :category

    def slugger
        "#{name} #{address}"
    end
    
    def should_generate_new_friendly_id?
        name_changed? || address_changed?
    end

    def event_image?
        errors.add(:base, 'Please upload a cover image for your event.') unless image.attached?
    end
    
end

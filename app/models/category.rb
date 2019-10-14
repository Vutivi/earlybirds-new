class Category < ApplicationRecord
    include Resizable

    extend FriendlyId
    friendly_id :slugger, use: :slugged

    validates :name, :description, presence: true
    validates_uniqueness_of :name
    validates :name, length: {minimum: 3, maximum: 30}
    validates :description, length: {minimum: 3, maximum: 500}
    has_many :events
    validate :category_image?

    has_one_attached :image

    def slugger
        name
    end
    
    def should_generate_new_friendly_id?
        name_changed?
    end


    def category_image?
        errors.add(:base, 'Please upload a cover image for your category.') unless image.attached?
    end
end

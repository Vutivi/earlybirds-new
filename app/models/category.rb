class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :slugger, use: :slugged

    validates :name, :description, presence: true
    validates_uniqueness_of :name
    validates :name, length: {minimum: 3, maximum: 30}
    validates :description, length: {minimum: 3, maximum: 500}
    has_many :events

    def slugger
        name
    end
    
    def should_generate_new_friendly_id?
        name_changed?
    end

end

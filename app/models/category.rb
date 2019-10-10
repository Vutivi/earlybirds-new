class Category < ApplicationRecord
    validates :name, :description, presence: true
    validates_uniqueness_of :name
    validates :name, length: {minimum: 3, maximum: 30}
    validates :description, length: {minimum: 3, maximum: 500}
    has_many :events
end

class Plan < ApplicationRecord
    validates :name, :price, :perks, :length, :description, presence: true
    validates_uniqueness_of :name, :price
end

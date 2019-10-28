class CarMake < ApplicationRecord
    validates_uniqueness_of :name
end

class Location < ApplicationRecord
  has_many :travellings, dependent: :destroy
end

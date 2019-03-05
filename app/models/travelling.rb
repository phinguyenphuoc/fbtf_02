class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location
end

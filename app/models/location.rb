class Location < ApplicationRecord
  has_many :travellings, dependent: :destroy
  validates :name, uniqueness: true
  scope :ordered_by_name, ->{order("name desc")}
end

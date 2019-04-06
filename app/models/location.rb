class Location < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :name_changed?
  has_many :travellings_start_id, class_name: Travelling.name,
    foreign_key: :location_start, dependent: :destroy
  has_many :travellings_end_id, class_name: Travelling.name,
    foreign_key: :location_end, dependent: :destroy

  validates :name, uniqueness: true

  scope :ordered_by_name, ->{order name: :desc}
end

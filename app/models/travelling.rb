class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location_start, class_name: Location.name,
    foreign_key: :location_start_id
  belongs_to :location_end, class_name: Location.name,
    foreign_key: :location_end_id
  validates_uniqueness_of :location_start_id, scope: :location_end_id
  validate :start_end_must_be_different

  def start_end_must_be_different
    errors.add(:location_start_id, "start end must be difference") if
      location_start_id == location_end_id
  end
end

class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :category
  belongs_to :travelling
  delegate :name, to: :category
  scope :order_new_tours, ->{order :created_at}
  scope :search, (lambda do |travelling_ids|
    where travelling_id: travelling_ids if travelling_ids
  end)
end

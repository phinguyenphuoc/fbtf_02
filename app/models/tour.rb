class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :category
  belongs_to :travelling
  delegate :name, to: :category
  scope :order_new_tours, ->{order :created_at}
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  enum status: {waitting: 0, refuse: 1, approve: 2}

  validates :name, presence: true, length: {maximum: Settings.booking.max_name}
  validates :phonenumber, presence: true, numericality: true,
            length: {minimum: Settings.booking.min_phone,
                     maximum: Settings.booking.max_phone}
  validates :address, presence: true
  validates :quantity, presence: true

  scope :order_bookings, ->{order(created_at: :desc)}
end

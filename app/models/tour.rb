class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :category
  belongs_to :travelling
  validates :price, presence: true, numericality: {only_integer: true}
  validates :max_quantity, presence: true,
    numericality: { less_than_or_equal_to: 100,  only_integer: true }
  validate :start_must_be_before_end_time
  validates :time_start, presence: true
  validates :time_end, presence: true

  def start_must_be_before_end_time
    return errors.add(:time_start, "must be before end time") if
      time_start > time_end
  end
end

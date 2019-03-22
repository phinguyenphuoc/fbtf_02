class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  enum status: {waitting: 0, refuse: 1, approve: 2}
end

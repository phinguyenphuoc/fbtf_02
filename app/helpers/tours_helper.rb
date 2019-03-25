module ToursHelper
  def count_date end1, start1
    (end1.to_date - start1.to_date).to_i
  end

  def check_time_start time_start
    time_start >= Date.current
  end

  def check_booking_quantity max, recent
    (max - recent).positive?
  end
end

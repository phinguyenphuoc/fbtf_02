class ToursController < ApplicationController
  def index
    @travel_end = Travelling.location.select("l1.name as name, l2.name as name1, count(l1.name) as count,
      travellings.location_end_id as id_end")
    .joins(:joins)
    .joins("join locations as l1 ON travellings.location_end_id = l1.id")
    .joins("join locations as l2 ON travellings.location_start_id = l2.id")
    .order("count desc")
    .group("travellings.location_end_id")
    .limit(10)
  end

  def show

  end
end

class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location

  scope :hottour, ->{
    select("travellings.id as id,tours.price as price,
    l1.name as name_start,
    l2.name as name_end,
    sum(tours.recent_quantity) as sum1,
    tours.avatar as avatar,
    tours.description as description,
    tours.time_start as time_start,
    tours.time_end as time_end")
      .joins("JOIN tours on travellings.id = tours.travelling_id")
      .joins("LEFT JOIN locations as l1
        ON travellings.location_start_id = l1.id")
      .joins("LEFT JOIN locations as l2
        ON travellings.location_end_id = l2.id")
      .order("sum1 desc")
      .group("tours.travelling_id")}
end

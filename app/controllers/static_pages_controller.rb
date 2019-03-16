class StaticPagesController < ApplicationController
  def home
    @new_tours = Tour.order(:created_at).limit(6)
  end
end

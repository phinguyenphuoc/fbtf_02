class StaticPagesController < ApplicationController
  def home
    @hot_tour = Travelling.hottour.limit(Settings.static_pages.hottour)
  end
end

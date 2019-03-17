class LikesController < ApplicationController
  before_action :find_review, only: [:index, :create]
  before_action :find_tour, only: [:index, :create, :destroy]
  before_action :current_user, only: [:show, :destroy]
  before_action :find_like, only: [:destroy]

  def create
    @like = current_user.likes.new
    @review.tour_id = @tour.id
    @like.review_id = @review.id

    unless already_liked?
      return redirect_to tour_path(@tour) if @like.save
    end
    flash[:danger] = t "like_fail"
    redirect_to tour_path(@tour)
  end

  def destroy
    @unlike.destroy
    redirect_to tour_path(@tour)
  end

  private

  def find_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def already_liked?
    Like.where(user_id: current_user.id, review_id:
      params[:review_id]).exists?
  end

  def find_like
    @unlike = Like.find_by id: params[:like_id]
    return if @unlike
    flash[:danger] = t "no_data"
    redirect_to root_path
  end
end

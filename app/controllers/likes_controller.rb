class LikesController < ApplicationController
  before_action :find_review, only: :create
  before_action :find_like, only: :destroy

  def create
    if already_liked?
      flash[:danger] = t "like_fail"
    else
      @like = current_user.likes.create(review_id: @review.id)
    end
    redirect_to request.referrer
  end

  def destroy
    return redirect_to request.referrer if @unlike.destroy
    flash[:danger] = t "fail"
    redirect_to request.referrer
  end

  private

  def find_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def already_liked?
    Like.already_liked(current_user.id, params[:review_id]).exists?
  end

  def find_like
    @unlike = Like.find_by id: params[:like_id]
    return if @unlike
    flash[:danger] = t "no_data"
    redirect_to root_path
  end
end

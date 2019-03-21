module LikesHelper
  def pre_like id_review
    current_user.likes.find{|like| like.review_id == id_review}
  end
end

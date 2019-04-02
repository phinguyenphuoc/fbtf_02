module SessionsHelper
  def current_user? user
    user == current_user
  end

  def is_like? review_id
    current_user.likes.load_by_user(review_id).exists?
  end
end

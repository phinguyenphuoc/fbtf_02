class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  scope :already_liked, (lambda do |user_id, review_id|
    where user_id: user_id, review_id: review_id
  end)
  scope :load_by_user, ->(review_id){where review_id: review_id}
end

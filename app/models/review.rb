class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :likes, dependent: :destroy

  mount_uploader :picture, PictureUploader

  validates :content, presence: true
  validate  :picture_size

  scope :order_reviews, ->{order created_at: :asc}
  scope :user_review, ->(user_id){where user_id: user_id}

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:picture, "Settings.review.picture_size") if
      picture.size > Settings.review.picture.megabytes
  end
end

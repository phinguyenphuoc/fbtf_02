class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :likes, dependent: :destroy

  mount_uploader :picture, PictureUploader

  validates :content, presence: true, length: {minimum: Settings.review.length_review}
  validate  :picture_size

  scope :order_reviews, ->{order(created_at: :desc)}

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:picture, "than 5MB") if picture.size > 5.megabytes
  end
end

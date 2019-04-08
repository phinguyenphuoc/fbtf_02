class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable, omniauth_providers: %i[facebook]
  CSV_ATTRIBUTES = %w(name email phonenumber).freeze
  has_many :bookings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  before_save :downcase_email

  enum role: {user: 0, admin: 1}

  scope :all_except, ->(user){where.not(id: user)}
  scope :ordered_by_name, ->{order name: :desc}

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email =
        "#{auth.info.name}@#{auth.provider}.com".downcase.gsub(/\s+/, "")
      user.password = Devise.friendly_token[6, 20]
      user.name = auth.info.name
      user.confirmed_at = Time.now
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] &&
        session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end

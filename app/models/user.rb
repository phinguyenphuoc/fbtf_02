class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable
  CSV_ATTRIBUTES = %w(name email phonenumber).freeze
  has_many :bookings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  before_save :downcase_email

  enum role: {user: 0, admin: 1}

  validates :name, presence: true
  # validates :phonenumber, presence: true, numericality: true,
  #           length: {minimum: Settings.user.min_phone,
  #                    maximum: Settings.user.max_phone}
  scope :all_except, ->(user){where.not(id: user)}
  scope :ordered_by_name, ->{order name: :desc}

  def self.create_with_omniauth auth
    user = find_or_create_by(uid: auth["uid"], provider: auth["provider"])
    user.email =
      "#{auth['info']['name']}@#{auth['provider']}.com".downcase.gsub(/\s+/, "")
    user.password = auth["uid"]
    user.provider = auth["provider"]
    user.name = auth["info"]["name"]
    begin
      user.save!
    rescue Exception => e
      puts "Error: #{e}"
    end
    user
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end

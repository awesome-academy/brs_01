class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  NUMBER_REGEX = /\d[0-9]\)*\z/
  has_many :active_follows, class_name: Follow.name,
    foreign_key: :follower_id
  has_many :passive_follows, class_name: Follow.name,
    foreign_key: :following_id
  has_many :following, through: :active_follows, source: :following
  has_many :follows, through: :passive_follows, source: :follower
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :books, through: :activities
  enum role: {admin: 0, user: 1}
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :phone, presence: true,
    format: {with: NUMBER_REGEX}
  has_secure_password
  def self.digest string
    if cost = ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end
end

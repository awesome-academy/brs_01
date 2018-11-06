class Book < ApplicationRecord
  PRICE_VND_REGEX = /\A\d{1,12}\z/
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :users, through: :activities
  validates :price, presence: true, format: {with: PRICE_VND_REGEX}
  default_scope {order(created_at: :DESC)}
end

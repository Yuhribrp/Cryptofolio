class Crypto < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :amount_owned, presence: true
  validates :unit_price, presence: true
end

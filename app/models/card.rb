class Card < ApplicationRecord

  validates :name, presence: true
  validates :user_id, presence: true
  validates :balance_id, presence: true
end

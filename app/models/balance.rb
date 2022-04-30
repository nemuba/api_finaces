class Balance < ApplicationRecord
  belongs_to :user

  validates :balance_value, presence: true
  validates :balance_value, numericality: { greater_than_or_equal_to: 0 }
end

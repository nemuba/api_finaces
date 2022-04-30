FactoryBot.define do
  factory :balance do
    user { create(:user) }
    balance_value { 1500 }
  end

  factory :balance_invalid, parent: :balance do
    user { nil }
    balance_value { -1 }
  end
end

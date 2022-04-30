require 'rails_helper'

RSpec.describe Balance, type: :model do
  it 'with valid attributes' do
    balance = build(:balance)

    expect(balance).to be_valid
  end

  it 'with attributes invalid' do
    balance_invalid = build(:balance_invalid)

    expect(balance_invalid).to be_invalid
  end

  it 'with balance_value invalid' do
    balance = build(:balance, balance_value: -1)

    expect(balance).to be_invalid
  end

  it 'with user invalid' do
    balance = build(:balance, user: nil)

    expect(balance).to be_invalid
  end
end

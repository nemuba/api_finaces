# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'with invalid attributes' do
    user_invalid = build(:user_invalid)
    expect(user_invalid).to be_invalid
  end

  it 'with email invalid' do
    expect(build(:user, email: nil)).to be_invalid
    expect(build(:user, email: 'invalid')).to be_invalid
  end

  it 'with password invalid' do
    expect(build(:user, password: nil)).to be_invalid
    expect(build(:user, password: '')).to be_invalid
    expect(build(:user, password: '123')).to be_invalid
  end

  it 'with name invalid' do
    expect(build(:user, name: nil)).to be_invalid
    expect(build(:user, name: '')).to be_invalid
  end
end

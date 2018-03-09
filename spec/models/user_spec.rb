require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with duplicate email address" do
    User.create(
      name: "joe",
      email: "tester@example.com",
      password: "password"
    )
    user = User.new(
      name: "jane",
      email: "tester@example.com",
      password: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end

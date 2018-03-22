require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { expect(user).to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password) }
  end

  it { is_expected.to define_enum_for(:role) }

  describe "is invalid with a duplicate email address" do
    subject { build(:user) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "is invalid with a duplicate name" do
    subject { build(:user) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end

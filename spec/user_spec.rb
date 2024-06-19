require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end

  it "is not valid without a name" do
    @user.name = "     "
    expect(@user).not_to be_valid
  end

  it "is not valid with a name that is too long" do
    @user.name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "is not valid with an email that is too long" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "accepts valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "rejects invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "requires a unique email address" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user).not_to be_valid
  end
end

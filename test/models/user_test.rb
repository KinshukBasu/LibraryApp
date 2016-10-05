require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.create(name: 'User', email: 'fisdfisdfns@example.com', password: 'password', password_confirmation: 'password', role: 1,
                     phoneNumber: '1234567890')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "Phone number must be 10 digits" do
    @user.phoneNumber = '123'
    assert_not @user.valid?
  end

  test "Email must have valid syntax" do
    @user.email = 'invalidvalue'
    assert_not @user.valid?
  end

  test "Do not save without email" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "Password confirmation should match password" do
    @user.password = 'password'
    @user.password_confirmation = 'abcd123'
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    user1 = @user.dup
    @user.save
    assert_not user1.valid?
  end


end


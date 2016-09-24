require 'test_helper'

class SignUpControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_up_new_url
    assert_response :success
  end

  test "should get create" do
    get sign_up_create_url
    assert_response :success
  end

end

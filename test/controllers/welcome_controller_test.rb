require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get welcome_display_url
    assert_response :success
  end

end

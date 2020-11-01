require 'test_helper'

class CircleControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get circle_new_url
    assert_response :success
  end

  test "should get index" do
    get circle_index_url
    assert_response :success
  end

  test "should get show" do
    get circle_show_url
    assert_response :success
  end

end

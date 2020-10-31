require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get movies_request_url
    assert_response :success
  end

  test "should get search" do
    get movies_search_url
    assert_response :success
  end

end

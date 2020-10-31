require 'test_helper'

class WatchlistControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get watchlist_new_url
    assert_response :success
  end

  test "should get create" do
    get watchlist_create_url
    assert_response :success
  end

end

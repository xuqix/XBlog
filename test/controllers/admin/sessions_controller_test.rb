require 'test_helper'

class Admin::SessionsControllerTest < ActionController::TestCase
  def setup
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect to root when log error" do
    post :create, session: {username: 'abcdefg', password: '1234567'}
    assert_template 'sessions/new'
  end

  test "should redirect to articles when log success" do
    log_in_as_admin
    post :create, session: {username: ENV['XBLOG_USERNAME'], password: ENV['XBLOG_PASSWORD']}
    assert_redirected_to admin_articles_path
  end
end

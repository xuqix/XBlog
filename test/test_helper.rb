ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def log_in_as_admin
    if integration_test?
      # post admin_sessions_path, session: {
      #   username: ENV['XBLOG_USERNAME'],
      #   password: ENV['XBLOG_PASSWORD']
      # }
        session[:admin] = true
      else
        session[:admin] = true
      end
  end

  private
  # 在集成测试中返回 true
  def integration_test?
    defined?(post_via_redirect)
  end
end

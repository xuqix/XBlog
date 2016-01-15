class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :format_time

  def format_time(time)
    time.localtime.strftime("%Y-%m-%d %H:%M")
  end
end

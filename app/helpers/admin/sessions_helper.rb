module Admin::SessionsHelper
  def authenticate!
    if ! session[:admin]
      flash[:error] = '请先登录后台管理!'
      cookies[:urlback] = request.original_url
      redirect_to new_admin_session_path
    end
  end

  def log_in(params)
    if session[:admin] != true
      digest = Digest::SHA1.hexdigest(params[:password])
      if ENV['XBLOG_USERNAME'].blank?
        session[:admin] = false
      elsif params[:username] != ENV['XBLOG_USERNAME']
        session[:admin] = false
      elsif digest != ENV['XBLOG_PASSWORD']
        session[:admin] = false
      else
        session[:admin] = true
      end
    end
    session[:admin]
  end

  def log_out()
    session.delete(:admin)
  end

  def is_logged?
    session[:admin] == true
  end
end

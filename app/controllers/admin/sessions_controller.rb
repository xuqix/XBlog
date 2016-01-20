class Admin::SessionsController < ApplicationController
  def new
    if is_logged?
      redirect_to admin_articles_path
    end
  end

  def create
    if log_in(session_params)
      flash[:success] = "Welcome to the XBlog, my master!"
      redirect_to admin_articles_path
    else
      flash.now[:warning] = "Username or Password Error!"
      render 'new'
    end
  end

  def destroy
    log_out if is_logged?
    redirect_to new_admin_session_path
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end

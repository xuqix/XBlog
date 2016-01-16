class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if log_in(session_params)
      redirect_to admin_articles_path
    else
      redirect_to new_admin_session_path
    end
  end

  def destroy
    log_out
    redirect_to new_admin_session_path
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end

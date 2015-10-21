class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by :email => params[:email]
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_news_path
    else
      redirect_to login_path, notice: 'Incorrect Email or Password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
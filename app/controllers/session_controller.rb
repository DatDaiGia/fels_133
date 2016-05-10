class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "activerecord.controller.session.success"
      redirect_to user
    else
      flash.now[:error] = t "activerecord.controller.session.error"
      render :new
    end
  end

  def destroy
    if logged_in?
      log_out
      redirect_to root_url
    end
  end
end

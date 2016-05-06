class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]  	
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "activerecord.controller.user.success"
      redirect_to @user  
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:update_success] = t "activerecord.controller.user.update_success"
      redirect_to @user 
    else
      render :edit
    end  
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "activerecord.controller.user.danger"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless @user.correct_user? current_user
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end

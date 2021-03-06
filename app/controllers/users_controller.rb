class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :edit]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You has been registered!"
      redirect_to root_path
    else
      flash[:error] = "There's something wrong with your username or password."
      render :new
    end

  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end

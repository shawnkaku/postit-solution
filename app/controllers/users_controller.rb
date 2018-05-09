class UsersController < ApplicationController

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
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end

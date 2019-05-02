# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "Could not find user with id: #{params[:id]}"
      redirect_to root_path, status: 302
    end
  end

  def login; end

  def logout; end

  def myaccount
    @user = User.find_by(id: session[:user_id])
    # this will be the current logged in user's merchant dashboard
  end

  def orders
    # this will be the current logged in user's orders, if we want that as its own page
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :uid, :provider, :name)
  end
end

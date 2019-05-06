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

  def login
    auth_hash = request.env["omniauth.auth"]

    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.name}"
      else
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end

    session[:user_id] = user.id
    return redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  def myaccount
    @user = User.find_by(id: session[:user_id])
    # this will be the current logged in user's merchant dashboard
  end

  def myorders
    @user = User.find_by(id: 2)
    # this will be the current logged in user's orders, if we want that as its own page
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :uid, :provider, :name)
  end
end

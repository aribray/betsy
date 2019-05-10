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
    @products = @user.products.where("quantity > ?", 0).sort_by { |product| product.created_at }.reverse
  end

  def login
    auth_hash = request.env["omniauth.auth"]

    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      if auth_hash["provider"] == "github"
        user = User.build_from_github(auth_hash)
        if user.save
          flash[:success] = "Logged in as new user #{user.name}"
        else
          flash[:error] = "Could not create new user account"
          return redirect_to root_path
        end
      else
        flash[:error] = "Could not create new user account"

        return redirect_to root_path
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  def myaccount
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to root_path
      flash[:error] = "You must be logged in to do that."
    end
  end

  def myorders
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to root_path
      flash[:error] = "You must be logged in to do that."
    end
  end
end

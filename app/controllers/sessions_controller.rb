class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email" => params["email"]})
    # 2. if the user exists -> check if they know their password
    if @user != nil
    # 3. if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"])== params["password"] 
        cookies["monster"] = "i like it"
        session["user_id"] = @user["id"]
        flash["notice"] = "welcome"
        redirect_to "/companies"
      else
        flash["notice"] = "No"
        redirect_to "/login"
      end 
    # 4. if the user doesn't exist or they don't know their password -> login fails
    else
      flash["notice"] = "No"
      redirect_to "/login"
    end
  end

  def destroy
    # logout the user
    cookies["monster"] = nil
    sessions["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end

class PasswordController < ApplicationController
  def check
    @user_id = params[:userid]
    @password = params[:password]
    session[:user] = @user_id
    @result = "Guess a number."
    if (check_username? && check_password?)
      render "game/try.html.erb"
    else
      flash.now[:alert] = "Credentials are invalid. Try again."
      render "check/loginfailed.html.erb"
    end
  end

  def check_username?
    if (@user_id.strip.length >= 6 && @user_id.downcase != "username" && !(@user_id.include?("!") || @user_id.include?("$") || @user_id.include?("#")))
      true
    else
      false
    end
  end

  def check_password?
    if (@password.strip.length >= 6 && @password.downcase != "password" && @password != @user_id && (@password.include?("!") || @password.include?("$") || @password.include?("#")))
      true
    else
      false
    end
  end
end

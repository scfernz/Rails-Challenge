class GameController < ApplicationController
  def try
    if session[:counter].nil?
      session[:counter] = 0
    end

    if session[:comp_number].nil?
      session[:comp_number] = rand(100)
    end

    if session[:win].nil?
      session[:win] = 0
    end

    if (params[:guess].to_i > 100) || (params[:guess].to_i < 1)
      flash.now[:alert] = "Invalid input. Try again, dude."
    end

    @user_num = params[:guess].to_i
    @comp_number = session[:comp_number]
    @counter = session[:counter].to_i
    @win = session[:win].to_i

    if (@user_num > @comp_number.to_i) && @counter < 7 && @win == 0 && ((params[:guess].to_i < 100) && (params[:guess].to_i > 1))
      @counter += 1
      session[:counter] = @counter
      session[:win] = @win
      @result = @user_num.to_s + ' is too high, ' + session[:user].to_s  + '!'
    end

    if (@user_num < @comp_number.to_i) && @counter < 7 && @win == 0 && ((params[:guess].to_i < 100) && (params[:guess].to_i > 1))
      @counter += 1
      session[:counter] = @counter
      session[:win] = @win
      @result = @user_num.to_s + ' is too low, ' + session[:user].to_s + '!'
    end

    if (@user_num == @comp_number.to_i) && @counter < 7 && @win == 0 && ((params[:guess].to_i < 100) && (params[:guess].to_i > 1))
      # @result = @user_num.to_s + ' is correct. You win!'
      @win = 1
      session[:win] = @win
      # session[:comp_number] = rand(100)
      # @counter = 0
      # session[:counter] = @counter
    end

    if @win == 1
      @result = @comp_number.to_s + ' is correct. You win, ' + session[:user].to_s + '!'
    end

    if @counter >= 7
      @result = 'Too many tries. You suck, ' + session[:user].to_s + '.'
      # @counter = 0
      # session[:counter] = @counter
      # session[:comp_number] = rand(100)
    end
    render "try.html.erb"
  end

  def refresh
    @result = "Guess a number."
    @counter = 0
    @win = 0
    session[:win] = @win
    session[:counter] = @counter
    session[:comp_number] = rand(100)
    render "try.html.erb"
  end
end

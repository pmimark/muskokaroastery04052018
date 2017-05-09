class UserSessionsController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    if params[:user] == "guest" 
      session[:order] = params
    end
  end

  def create
    # if params[:user] == "guest" 
    #   session[:order] = params
    # end
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if params[:user] == "guest" 
        redirect_to "/shop/checkout?return=true",:notice => "You are now logged in."
      else
        destination_url = root_url
        # destination_url = shop_checkout_path if params[:d] && params[:d] == 'checkout'
        redirect_to destination_url, :notice => "You are now logged in."
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url, :notice => "You are now logged out."
  end

  

end

class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @microposts = current_user.microposts.build
      @feed_items = current_user.feed
    else
      redirect_to sign_in_path
      flash[:danger] = "You must sign in or sign up to continue"
    end
  end
end

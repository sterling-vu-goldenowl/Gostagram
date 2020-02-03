class StaticPagesController < ApplicationController
  def home
    if authenticate_user!
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed
    end
  end
end

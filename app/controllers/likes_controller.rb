class LikesController < ApplicationController
  before_action :set_micropost, only: %i[create destroy]

  def create
    @like = @micropost.likes.build(user_id: current_user.id)
    @like.save!

    respond_to do |format|
      format.html { redirect_to @like }
      format.js { render layout: false }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @like }
      format.js { render layout: false }
    end
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end

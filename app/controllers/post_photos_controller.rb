# frozen_string_literal: true

class PostPhotosController < ApplicationController
  def destroy
    @post_photo = PostPhoto.find_by(id: params[:id], micropost_id: params[:micropost_id])
    @micropost = Micropost.find(params[:micropost_id])
    # micropost = @post_photo.micropost
    @post_photo.destroy

    redirect_to edit_micropost_path(@micropost)
  end
end

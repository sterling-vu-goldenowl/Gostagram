# frozen_string_literal: true

class PostPhotosController < ApplicationController
  def destroy
    @post_photo = PostPhoto.find(params[:id])
    # micropost = @post_photo.micropost
    @post_photo.destroy
    respond_to do |format|
      format.html do
        redirect_to user_path(current_user),
                    notice: 'Photo was successfully deleted!'
      end
    end
  end
end

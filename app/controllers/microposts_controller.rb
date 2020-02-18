# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :user_signed_in?, only: %i[create new update show edit update]
  before_action :set_micropost, only: %i[show destroy check_user_micropost edit update]
  before_action :check_user_micropost, only: %i[destroy edit update]

  def show
    @post_photos = @micropost.post_photos.all
  end

  def new
    @micropost = current_user.microposts.build
    @post_photo = @micropost.post_photos.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      redirect_to @micropost
    else
      @post_photo = @micropost.post_photos.build
      redirect_to action: :new
      flash[:danger] = "Content and photo can't be blank and photo must < 5MB."
    end
  end

  def edit; end

  def update
    @micropost.assign_attributes(micropost_params)

    if @micropost.save
      redirect_to @micropost,
                  notice: 'Micropost was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    redirect_to user_path(current_user),
                notice: 'Your post was successfully deleted!'
  end

  private

  def check_user_micropost
    return if current_user == @micropost.user

    redirect_to root_path
    flash[:danger] = "You don't allow this action."
  end

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(
      :content,
      post_photos_attributes: %i[id photo _destroy]
    )
  end
end

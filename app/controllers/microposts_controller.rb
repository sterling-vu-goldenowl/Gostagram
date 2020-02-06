# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :user_signed_in?, only: %i[create destroy new update edit show]
  before_action :set_micropost, only: %i[show edit update destroy check_user_micropost]
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

    # respond_to do |format|
    #   if @micropost.save
    #     params[:post_photos]['photo'].each do |a|
    #       @post_photo = @micropost.post_photos.create!(photo: a)
    #     end
    #     format.html do
    #       redirect_to @micropost,
    #                   notice: 'Micropost was successfully created!'
    #     end
    #   else
    #     format.html { render :new }
    #   end
    # end

    if @micropost.save
      # params[:post_photos]['photo'].each do |a|
      #   @post_photo = @micropost.post_photos.create!(photo: a)
      # end
      redirect_to @micropost
    else
      flash[:danger] = @micropost.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit; end

  def update
    @micropost.assign_attributes(micropost_params)
    if @micropost.save
      params[:post_photos]['photo'].each do |a|
        @post_photo = @micropost.post_photos.create!(photo: a)
      end
      redirect_to @micropost,
                  notice: 'Micropost was successfully updated!'
    else
      flash[:danger] = @micropost.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html do
        redirect_to user_path(current_user),
                    notice: 'Your post was successfully deleted!'
      end
    end
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
      post_photos_attributes: %i[id item_id photo]
    )
  end
end

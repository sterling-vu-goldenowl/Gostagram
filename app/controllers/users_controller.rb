# frozen_string_literal: true

class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: %i[show edit update correct_user]
  before_action :correct_user, only: %i[edit update]
  before_action :signed_in?, only: %i[edit update show]

  def show; end

  def edit; end

  def update
    if @user.update_attributes(update_params)
      redirect_to @user, notice: 'Profile updated'
    else
      render :edit
    end
  end

  private

  def update_params
    allow = %i[email username avatar]
    params.require(:user).permit(allow)
  end

  def correct_user
    redirect_to(root_path) unless current_user?(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

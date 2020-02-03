# frozen_string_literal: true

class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: %i[show edit update correct_user]
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :valid_user?, only: %i[edit update]

  def show
    @microposts = @user.microposts
  end

  def edit; end

  def update
    remove_params_password
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to @user, notice: 'Profile updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :avatar,
      :password,
      :password_confirmation
    )
  end

  def valid_user?
    return if current_user == @user

    redirect_to(root_path, notice: 'You don\'t allow this action.')
  end

  def set_user
    @user = User.find(params[:id])
  end

  def remove_params_password
    if params[:user][:password].blank?
      params.dig(:user).delete(:password)
      params.dig(:user).delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
  end
end

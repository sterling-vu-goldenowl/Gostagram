# frozen_string_literal: true

class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: %i[show edit update correct_user following followers valid_user?]
  before_action :user_signed_in?, only: %i[edit update following followers]
  before_action :valid_user?, only: %i[edit update]
  before_action :check_current_password, only: :update

  def show
    @microposts = @user.microposts
  end

  def edit; end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to @user, notice: 'Profile updated'
    else
      check_error_type
      respond_to do |format|
        format.html { render :edit }
        format.js { render layout: false }
      end
    end
  end

  def following
    @title = 'Following'
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers
    render 'show_follow'
  end

  private

  def check_current_password
    current_password = params.dig(:user, :current_password)
    if current_password && !current_user.valid_password?(current_password)
      @error_password = true
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :bio,
      :username,
      :avatar,
      :password,
      :password_confirmation
    )
  end

  def check_error_type
    errors = @user.errors.full_messages
    errors.each do |error|
      if error.include?('password')
        @error_password = true
      end
    end
  end

  def valid_user?
    return if current_user == @user

    redirect_to root_path
    flash[:danger] = "You don't allow this action."
  end

  def set_user
    @user = User.find(params[:id])
  end
end

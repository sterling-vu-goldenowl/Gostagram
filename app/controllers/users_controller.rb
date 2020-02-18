# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update correct_user following followers valid_user?]
  before_action :user_signed_in?, only: %i[edit update show following followers]
  before_action :valid_user?, only: %i[edit update]
  before_action :check_current_password, only: :update

  def search
    if search_params
      @search_results_users = User.search_user(search_params.dig(:search))
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def show
    @microposts = @user.microposts
  end

  def edit; end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      if @current_password && @error_password == false
        redirect_to sign_in_path, notice: 'Your password was successfully save. Please sign in again.'
      else
        redirect_to @user
      end
    else
      render :edit
    end
  end

  def following
    @title = 'Following'
    @follow = @user.following
    @users = @follow.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @follow = @user.followers
    @users = @follow.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def check_current_password
    @error_password = false
    @current_password = params.dig(:user, :current_password)

    return true if @current_password && current_user.valid_password?(@current_password)

    @error_password = true
    flash[:danger] = 'Your current password is wrong.'
    render :edit
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

  def search_params
    params.require(:search).permit(:search)
  end

  def valid_user?
    return if current_user == @user

    redirect_to root_path
    flash[:danger] = "You don't allow this action."
  end

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end
end

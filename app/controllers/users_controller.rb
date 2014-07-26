# encoding: utf-8
class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:follow, :unfollow]

  before_action :set_user

  def show
    if user_signed_in? and current_user.following?(@user)
      @photos = @user.photos.audited.follower.page params[:page]

    elsif user_signed_in? and current_user == @user
      @photos = @user.photos.page params[:page]

    else
      @photos = @user.photos.audited.published.page params[:page]
    end
  end

  def followers
    @users = @user.followers.page params[:page]
    render "follow"
  end

  def followed
    @users = @user.followed_users.page params[:page]
    render "follow"
  end

  def follow
    current_user.follow!(@user)
  end

  def unfollow
    current_user.unfollow!(@user)
  end

  def favorites
    @photos = @user.favorite_photos.page params[:page]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where(:username => params[:username]).first || User.where(:id => params[:username]).first

      render_404 if @user.nil?
    end

end

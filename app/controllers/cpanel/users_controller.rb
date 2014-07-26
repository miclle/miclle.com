# encoding: utf-8
class Cpanel::UsersController < Cpanel::ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.includes(:photos).page params[:page]
  end

  def show

  end

  def update
    if @user.update(user_params)
      redirect_to cpanel_user_url(@user), notice: 'User profile was successfully updated.'
    else
      render action: 'show'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end


  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit( :username,
                                    :avatar,
                                    :email,
                                    :name,
                                    :city,
                                    :bio,
                                    :gender,
                                    :website,
                                    :weibo,
                                    :twitter,
                                    :qq,
                                    :role
                                    )
    end

end

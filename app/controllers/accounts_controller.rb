# encoding: utf-8
class AccountsController < ApplicationController

  before_filter :authenticate_user!

  def show

  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to account_url, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def password
    if request.put?
      if current_user.valid_password?(params[:user][:password_old]) and current_user.update_attributes(:password => params[:user][:password])
        redirect_to new_user_session_path, :notice => '密码修改成功，您需要重新登录!'
      else
        render :action => :password
      end
    end
  end

  def notifications

  end

  private

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
                                    :qq
                                    )
    end

end

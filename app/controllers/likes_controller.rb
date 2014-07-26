# encoding: utf-8
class LikesController < ApplicationController

  before_filter :authenticate_user!

  before_action :set_likeable

  def create
    current_user.likes.create!(:likeable => @likeable)
  end

  def destroy
    current_user.likes.find_by_likeable_type_and_likeable_id(@likeable.class, @likeable.id).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = current_user.likes.find(params[:id])
    end

    def set_likeable
      @likeable = case params[:type]
                      when "photo" then Photo.find(params[:id])
                      end
    end

end

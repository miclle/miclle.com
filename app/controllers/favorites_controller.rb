# encoding: utf-8
class FavoritesController < ApplicationController

  before_filter :authenticate_user!

  before_action :set_favoriteable

  def create
    current_user.favorites.create!(:favoriteable => @favoriteable)
  end

  def destroy
    current_user.favorites.find_by_favoriteable_type_and_favoriteable_id(@favoriteable.class, @favoriteable.id).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = current_user.favorites.find(params[:id])
    end

    def set_favoriteable
      @favoriteable = case params[:type]
                      when "photo" then Photo.find(params[:id])
                      end
    end

end

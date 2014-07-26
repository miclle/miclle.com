# encoding: utf-8
class WelcomeController < ApplicationController

  def index
    # @photos = Photo.page params[:page]
    @photo = Photo.published.editors.offset(rand(Photo.published.editors.count)).first
  end

  def screensaver
    @photo = Photo.published.editors.first
    render :layout => false
  end

  def updating
    render :layout => false
  end

end

# encoding: utf-8
class Cpanel::PhotosController < Cpanel::ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy, :recommend, :unrecommend]

  def index
    @photos = (Photo.try("#{params[:type]}") || Photo).includes(:favorite_users).includes(:like_users).page(params[:page])
  end

  def show
    @photo.update(:state => "audited") if @photo.state == "unaudited"
    @albums = current_user.albums
    @previous = @photo.previous
    @next = @photo.next
  end

  def update
    if @photo.update(photo_params)
      redirect_to cpanel_photo_url(@photo), notice: 'Photo profile was successfully updated.'
    else
      render action: 'show'
    end
  end

  def recommend
    @photo.editor = current_user
    @photo.save
    render 'recommend'
  end

  def unrecommend
    @photo.editor = nil
    @photo.save
    render 'recommend'
  end

  def unaccepted
    @photo.state = 'unaccepted'
    @photo.save
    render 'unaccepted'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find params[:id]
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image,
                                    :name,
                                    :camera,
                                    :focal_length,
                                    :exposure_time,
                                    :aperture,
                                    :iso,
                                    :taken_at,
                                    :category,
                                    :privacy,
                                    :album_id,
                                    :description,
                                    :license,
                                    :latitude,
                                    :longitude,
                                    :is_adult_content,
                                    :tag_list
                                    )
    end
end

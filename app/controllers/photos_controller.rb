# encoding: utf-8
class PhotosController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :editors, :show, :qiniu_callback]

  skip_before_filter :verify_authenticity_token, :only => [:qiniu_callback]

  before_action :set_photo, only: [:edit]

  def index
    @photos = Photo.audited.published.page params[:page]
  end

  def editors
    @photos = Photo.audited.published.editors.page params[:page]
    render :grid
  end

  # def gallery
  #   @photos = Photo.page(params[:page]).per(20)
  #   respond_to do |format|
  #     format.html {render :layout => "gallery"}
  #     format.js {render :layout => false}
  #   end
  # end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
  end

  # GET /photos/new
  def new
    @upload_token = Qiniu::RS.generate_upload_token :scope              => Settings.private_bucket,
                                                    # :expires_in         => expires_in_seconds,
                                                    :callback_url       => 'http://miclle.com/photo/qiniu/callback',
                                                    # :callback_body      => "user=#{current_user.uuid}",
                                                    # :callback_body_type => 'application/x-www-form-urlencoded',
                                                    :customer           => current_user.uuid.to_s
                                                    # :escape             => 1
                                                    # :async_options      => async_callback_api_commands,
                                                    # :return_body        => custom_response_body
    # @photo = Photo.new
    # @albums = current_user.albums
  end

  # POST /photo/qiniu/callback
  def qiniu_callback
    begin
      @user = User.where(:uuid => params[:user_uuid]).first

      @photo = @user.photos.create(
                                    :image          =>  params[:key],
                                    :name           =>  params[:name],
                                    :size           =>  params[:size],
                                    :width          =>  params[:width],
                                    :height         =>  params[:height],
                                    :camera         =>  params[:model],                              #相机型号
                                    :taken_at       =>  EXIF.time(params[:taken_at]),                #时间
                                    :exposure_time  =>  EXIF.exposure_time(params[:exposure_time]),  #曝光时间
                                    :aperture       =>  EXIF.f_number(params[:f_number]),            #光圈
                                    :iso            =>  params[:iso],                                #ISO
                                    :focal_length   =>  EXIF.focal_length(params[:focal_length]),    #焦距
                                    :latitude       =>  EXIF.degrees(params[:latitude], params[:latitude_ref]),
                                    :longitude      =>  EXIF.degrees(params[:longitude], params[:longitude_ref]),
                                    :color_space    =>  params[:color_space]
                                  )

      render :json => {:success => true, :files => [{:image => @photo.small, :name => @photo.name, :url => photo_url(@photo)}]}
    rescue Exception => e
      render :json => {:success => false, :message => "上传失败!"}
    end
  end


  def edit
    @albums = current_user.albums
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.new(photo_params)
    @photo.name = params[:photo][:name] || params[:photo][:image].original_filename
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @photo }
        format.json { render :json => {files: [@photo.to_jq_upload]}, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    @photo = current_user.photos.find(params[:id])
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    Qiniu::RS.delete(Settings.photo_bucket, @photo.image)
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = current_user.photos.find(params[:id])
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

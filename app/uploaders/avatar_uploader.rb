# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :qiniu

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "avatars/#{model.uuid}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path "avatar_default_#{version_name}.png"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  process :convert => 'png'

  #
  # def scale(width, height)
  #   # do something
  # end

  def url(version = :small)
    version = Settings.photo.versions[version]
    return ActionController::Base.helpers.asset_path "avatar_default_#{version}.png" if model.attributes["avatar"].blank?
    "#{Settings.cdn_domain}/avatars/#{model.uuid}/#{model.attributes["avatar"]}/#{version}"
  end

  Settings.photo.versions.each do |version, style|
    define_method version do
      "#{Settings.cdn_domain}/avatars/#{model.uuid}/#{model.attributes["avatar"]}/#{style}"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      @name ||= SecureRandom.uuid_short
      "#{@name}".downcase
    end
  end

end

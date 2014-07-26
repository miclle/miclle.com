namespace :assets do

  def traverse_dir(file_path, files = [])
    if File.directory? file_path
      Dir.foreach(file_path) do |file|
        if file!="." and file!=".."
          traverse_dir(file_path+"/"+file, files) #{|x| yield x}
        end
      end
    else
      # yield  file_path
      file_path.slice! "#{Rails.root}/public/"
      files << file_path
    end
    files
  end

  desc 'sync assets to cdns'
  task :cdn => :environment do


    files = traverse_dir("#{Rails.root}/public/assets")

    files.each do |file|
      stat = Qiniu::RS.stat("miclle-static", "assets/application-543c7a4531a509787859a62355487474.csssdfsd")
      # p stat
      # if stat
      #   p stat
      # end
    end


    # upload_token = Qiniu::RS.generate_upload_token :scope => Settings.static_bucket

    # p upload_token

    # Dir.foreach("#{Rails.root}/public/assets") do |file|
    #   puts file
    # end

    # Photo.all.each do |photo|
    #   key = "#{photo.user.uuid}/#{SecureRandom.hex(18)}"
    #   hash = Qiniu::RS.upload_file  :uptoken            => upload_token,
    #                                 :file               => photo.image.path,
    #                                 :bucket             => 'miclle',
    #                                 :key                => key
    #   p hash
    # end
  end

end

namespace :photo do

  # desc 'sync assets to cdns'
  task :download => :environment do
    download_token = Qiniu::RS.generate_download_token :pattern => "*"

    # http://<绑定域名>/<key>?token=<downloadToken>

    Photo.all.each do |photo|
      p photo.image
    end
  end

end

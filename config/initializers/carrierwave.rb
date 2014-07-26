::CarrierWave.configure do |config|

  config.storage             = :qiniu
  config.qiniu_access_key    = Settings.qiniu_access_key
  config.qiniu_secret_key    = Settings.qiniu_secret_key
  config.qiniu_bucket        = Settings.photo_bucket
  config.qiniu_bucket_domain = Settings.cdn_domain
  # config.qiniu_block_size    = 4*1024*1024
  # config.qiniu_protocal      = "http"
end
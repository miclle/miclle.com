require "redis"
require "redis-namespace"
require "redis/objects"

Redis::Objects.redis = Redis.new(:host => Settings.redis.host, :port => Settings.redis.port)

sidekiq_url = "redis://#{Settings.redis.host}:#{Settings.redis.port}/0"

Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'sidekiq', :url => sidekiq_url }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'sidekiq', :url => sidekiq_url }
end
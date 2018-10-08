redis_url = ENV['REDISCLOUD_URL'].present? ? ENV['REDISCLOUD_URL'] : 'redis://127.0.0.1:6379'

Sidekiq.configure_server do |config|
  config.redis = {url: redis_url, namespace: 'sidekiq-www-nihongo-chushin'}
end

Sidekiq.configure_client do |config|
  config.redis = {url: redis_url, namespace: 'sidekiq-www-nihongo-chushin'}
end

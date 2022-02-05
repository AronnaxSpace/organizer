require 'sidekiq/web'
require 'sidekiq/cron/web'

schedule_file = 'config/schedule.yml'

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

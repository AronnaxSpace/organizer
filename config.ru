require_relative 'config/environment'
require 'sidekiq'
require 'sidekiq/web'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

Dir[File.join(__dir__, 'app/controllers', '*.rb')].each do |file|
  use File.basename(file, '.rb').camelize.constantize
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

run Rack::URLMap.new('/' => ApplicationController, '/sidekiq' => Sidekiq::Web)

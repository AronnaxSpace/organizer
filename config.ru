require_relative 'config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

Dir[File.join(__dir__, 'app/controllers', '*.rb')].each do |file|
  use File.basename(file, '.rb').camelize.constantize
end

run Rack::URLMap.new('/' => ApplicationController, '/sidekiq' => Sidekiq::Web)

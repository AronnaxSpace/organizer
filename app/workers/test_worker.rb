require_relative '../../config/environment'

class TestWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical', retry: 5

  def perform(*args)
    User.first.tasks << Task.create(title: 'test')
  end
end

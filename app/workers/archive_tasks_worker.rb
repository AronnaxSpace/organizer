# frozen_string_literal: true

require_relative '../../config/environment'

class ArchiveTasksWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'default', retry: 3

  def perform
    Task.overdue.update(archived: true)
  end
end

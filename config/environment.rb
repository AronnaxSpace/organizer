# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'sinatra'
require 'bundler/setup'

if ENV['SINATRA_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end

Bundler.require(:default, ENV['SINATRA_ENV'])

require_relative 'initializers/sidekiq'

configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/organizer.sqlite3'
  )
end

require_all 'app'

# frozen_string_literal: true

class TasksController < ApplicationController
  get '/tasks' do
    redirect '/login' unless logged_in?

    @tasks = current_user.tasks.not_archived
    slim :'tasks/index.html', layout: :'layout.html'
  end

  get '/tasks/archive' do
    redirect '/login' unless logged_in?

    @tasks = current_user.tasks.archived
    slim :'tasks/archive.html', layout: :'layout.html'
  end

  post '/tasks/create' do
    @task = current_user.tasks.new(params)

    return [201, {}, [@task.attributes.select{ |a| ['id', 'title', 'deadline'].include? a }.to_json]] if @task.save

    [422, {}, [@task.errors.to_json]]
  end

  post '/tasks/:id/destroy' do
    @task = Task.find_by(id: params[:id])
    @task.destroy

    [200, {}, [params[:id]]]
  end
end

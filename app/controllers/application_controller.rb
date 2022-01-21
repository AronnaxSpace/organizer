class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get '/' do
    redirect '/tasks' if logged_in?

    slim :'/users/login.html', layout: :'layout.html'
  end

  get '/about' do
    slim :'/about.html', layout: :'layout.html'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def partial(name, locals: {})
      Slim::Template.new("#{settings.views}/#{name}.slim").render(self, locals)
    end
  end
end

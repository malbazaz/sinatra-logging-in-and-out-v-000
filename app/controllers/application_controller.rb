require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by_id(params[:user_id])
    if User.current_user
      session[:user_id] = @user_id
      redirect to '/account'
    else
      erb :error
    end
  end

  get '/account' do
  if User.is_logged_in?
    @user = User.find(session[:user_id])
  else
    @user = User.find_by_id(params[:user_id])
  end
    erb :account
  end

  get '/logout' do

  end


end

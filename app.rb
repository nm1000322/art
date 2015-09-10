require 'bundler'
Bundler.require
include BCrypt


DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

use Rack::Session::Cookie, :key => 'rack.session',
    :expire_after => 2592000,
    :secret => SecureRandom.hex(64)





get '/' do

  @user = User.first(:id => session[:id])

erb :landing
end

get '/gallery' do
  @user = User.first(:id => session[:id])
  @image = Image.all
erb :gallery
end

get '/about' do
  @user = User.first(:id => session[:id])
erb :aboutme
end

get '/image/:id' do
  @user = User.first(:id => session[:id])
  @i=Image.first(:id=>params[:id])
  erb :image
end

get '/upload' do
  @user = User.first(:id => session[:id])
  if session[:visited]
  erb :upload
  else
  redirect '/'
  end
end
get '/logout' do
  session.clear
  redirect '/'
end

get '/theater' do
  @user = User.first(:id => session[:id])
  @video = Video.all
  erb :theater
end
#######################################

post '/search' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @image = Image.where(:tag => params[:tag])
  erb :gallery
end

post '/searchvid' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @video = Video.where(:tag => params[:tag])
  erb :theater
end

post '/user/create' do
  u = User.new
  u.username = params[:username]
  u.password = Password.create(params[:password])
  u.save
  puts "hi"
  redirect '/upload'

end
post '/user/auth' do
  @u = User.first(:username => params[:username])
  if @u && Password.new(@u.password) == params[:password]
    session[:id] = @u.id
    session[:visited] = true
    redirect '/'
  else
  redirect '/'
  end
end

post '/uploading' do
  i = Image.new
  i.name = params[:name]
  i.url = params[:url]
  i.tag = params[:tag]
  i.caption = params[:caption]
  i.save
  redirect '/gallery'
end
post '/uploadvid' do
  i = Video.new
  i.name = params[:name]
  i.embed = params[:embed]
  i.tag = params[:tag]
  i.caption = params[:caption]
  i.save
  redirect '/theater'
end


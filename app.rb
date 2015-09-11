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
get '/video/:id' do
  @user = User.first(:id => session[:id])
  @i=Video.first(:id=>params[:id])
  erb :video
end
#######################################

post '/search' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @image = Image.where(:tag => params[:tag])
  erb :search
  #or gallery depending of which on is cleaner
end

post '/searchvid' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @video = Video.where(:tag => params[:tag])
  erb :searchvid
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
  time = Time.new
  i = Image.new
  @t = time.strftime("Posted on %A, %b %d %Y")
  i.name = params[:name]
  i.url = params[:url]
  i.tag = params[:tag]
  i.caption = params[:caption]
  i.date = time
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


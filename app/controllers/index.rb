get '/' do
  # Look in app/views/index.erb
  if session[:user_id]
    puts 'logged in'
  end
  erb :index
end


post '/login' do

  @user = User.where(first_name: params[:first_name]).first

  puts @user

  session[:first_name] = @user.first_name
  session[:user_id] = @user.id

  redirect '/'
end

get '/sign_up' do

  erb :sign_up
end

post '/sign_up' do
  @user = User.create(params)

  session[:first_name] = @user.first_name
  session[:user_id] = @user.id

  redirect '/'
end

get '/sign_out' do

  session.clear
  redirect '/'
end

get '/event/new' do

  erb :new_event
end

post '/event/new' do
  params[:user_id] = session[:user_id]
  Event.create(params)

  redirect '/'
end

get '/event/:id/edit' do
  @event = Event.find(params[:id])

  erb :edit_event
end

post '/event/:id/edit' do
  @event = Event.find(params[:id])

  puts "HERE!!!!: #{@event.name}"

  @event.name = params[:name]
  @event.location = params[:location]
  @event.starts_at = params[:starts_at]
  @event.ends_at = params[:ends_at]
  @event.save

  redirect '/'
end

get '/event/:id/delete' do
  Event.destroy(params[:id])

  redirect '/'

end
require 'rubygems'
require 'sinatra'
require 'environment'

# not_found do
#   'Not found'
# end

# error do
#   'Doh! error - ' + env['sinatra.error'].name
# end

helpers do
  # add some helpers.
end

get '/' do
  haml :home
end

get '/admin' do
  env['warden'].authenticate!
  haml :admin
end

post '/unauthenticated' do
  status 401
  haml :login
end

get '/login' do
  haml :login
end

post '/login' do
  env['warden'].authenticate!
  redirect '/admin'
end

get '/logout' do
  env['warden'].logout
  redirect '/'
end
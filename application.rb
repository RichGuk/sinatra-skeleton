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
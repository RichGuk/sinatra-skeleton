require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'haml'

require 'sinatra' unless defined?(Sinatra)

configure :development do
  DataMapper.setup(:default, {
    :adapter  => "sqlite3",
    :database => "development.db"
  })
end

configure :production do
  DataMapper.setup(:default, {
    :adapter  => "sqlite3",
    :database => "production.db"
  })
end

# Load Models
require 'models'
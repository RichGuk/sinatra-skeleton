require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'haml'

require 'sinatra' unless defined?(Sinatra)

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://development.db')

# Load Models
require 'models'
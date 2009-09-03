require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'haml'

require 'sinatra' unless defined?(Sinatra)

# Database setup.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/development.db")

# Load Models
require 'models'
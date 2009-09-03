require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'haml'

require 'sinatra' unless defined?(Sinatra)
require 'warden'

# Change the secret.
use Rack::Session::Cookie, :secret => '9d5a7827145c6e5bd5751f235dd5541160438d5c'

Warden::Manager.serialize_into_session{ |user| user.nil? ? nil : user.id }
Warden::Manager.serialize_from_session{ |id| id.nil? ? nil : User.get(id) }

Warden::Manager.before_failure do |env,opts|
  # Sinatra is very sensitive to the request method
  # since authentication could fail on any type of method, we need
  # to set it for the failure app so it is routed to the correct block
  env['REQUEST_METHOD'] = "POST"
end

Warden::Strategies.add(:password) do
  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    u = User.authenticate(params['username'], params['password'])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end

# Setup Warden.
use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = Sinatra::Application
end

# Database setup.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/development.db")

# Load Models
require 'models'
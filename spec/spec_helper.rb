require File.join(File.dirname(__FILE__), '..', 'application')

require 'spec'
require 'rack/test'

set :environment, :test
set :logging, false

# Setup in-memory database for testing.
DataMapper.setup(:default, "sqlite3::memory:")

Spec::Runner.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
  config.include Rack::Test::Methods
end
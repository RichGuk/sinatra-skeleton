require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'The Applicaiton App' do
  def app
    Sinatra::Application
  end

  it 'should load the index page successfully' do
    get '/'
    last_response.should be_ok
  end
end
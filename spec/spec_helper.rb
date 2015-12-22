$LOAD_PATH.unshift File.expand_path( '../../lib', __FILE__ )
require 'timeout'
require 'pritunl_api_client'

# NOTE: These specs are not unit tests, but rather system tests
# that require a live system to run against.

RSpec.configure do |config|
  config.before :all do
    @base_url   = ENV['BASE_URL']
    @api_token  = ENV['API_TOKEN']
    @api_secret = ENV['API_SECRET']
    fail 'Must set BASE_URL environment variable!'   unless @base_url
    fail 'Must set API_TOKEN environment variable!'  unless @api_token
    fail 'Must set API_SECRET environment variable!' unless @api_secret
  end
end

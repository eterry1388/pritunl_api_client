require_relative 'pritunl_api_client/api'
require_relative 'pritunl_api_client/settings'
require_relative 'pritunl_api_client/organization'
require_relative 'pritunl_api_client/user'
require_relative 'pritunl_api_client/key'
require_relative 'pritunl_api_client/server'

module PritunlApiClient
  class Client

    def initialize( base_url:, api_token:, api_secret:, verify_ssl: true )
      @base_url   = base_url
      @api_token  = api_token
      @api_secret = api_secret
      @verify_ssl = verify_ssl
      @api = Api.new( base_url: base_url, api_token: api_token, api_secret: api_secret, verify_ssl: verify_ssl )
    end

    def event
    end

    def ping
    end

    def status
    end

    def log
    end

    def settings
      Settings.new( @api )
    end

    def organization
      Organization.new( @api )
    end

    def user
      User.new( @api )
    end

    def key
      Key.new( @api )
    end

    def server
      Server.new( @api )
    end
  end
end

require_relative 'pritunl_api_client/api'
require_relative 'pritunl_api_client/settings'
require_relative 'pritunl_api_client/organization'
require_relative 'pritunl_api_client/user'
require_relative 'pritunl_api_client/key'
require_relative 'pritunl_api_client/server'

# API client for Pritunl. Pritunl is a distributed enterprise vpn server built
# using the OpenVPN protocol. See the official Pritunl API documentation here:
# https://pritunl.com/api.html. I am not affiliated with Pritunl at all, but
# couldn't find a Ruby client for their API. So I scratched my own itch and
# created it myself.
#
# @author {mailto:eterry1388@aol.com Eric Terry}
# @see https://github.com/eterry1388/pritunl_api_client
module PritunlApiClient

  # Main interface to the Pritunl api
  class Client

    # @param base_url [String] Full URL to a running Pritunl server (include the "https://")
    # @param api_token [String
    # @param api_secret [String]
    # @param verify_ssl [Boolean] Whether or not to verify SSL certificate
    def initialize( base_url:, api_token:, api_secret:, verify_ssl: true )
      @base_url   = base_url
      @api_token  = api_token
      @api_secret = api_secret
      @verify_ssl = verify_ssl
      @api = Api.new( base_url: base_url, api_token: api_token, api_secret: api_secret, verify_ssl: verify_ssl )
    end

    # Get a list of events (will poll up to 30 seconds)
    #
    # @param cursor [String, NilClass] Optional id of last event. If left out, only events
    #   that occurred after request is sent will be returned.
    # @return [Array]
    def event( cursor: nil )
      @api.get( "/event/#{cursor}" )
    end

    # Server healthcheck
    #
    # @return [Boolean]
    def ping
      begin
        @api.get( '/ping' ) == ''
      rescue
        false
      end
    end

    # Returns general information about the pritunl server
    #
    # @return [Hash]
    def status
      @api.get( '/status' )
    end

    # Returns a list of server log entries
    #
    # @return [Array]
    def log
      @api.get( '/log' )
    end

    # Setting apis
    #
    # @return [PritunlApiClient::Settings]
    def settings
      @settings ||= Settings.new( @api )
    end

    # Organization apis
    #
    # @return [PritunlApiClient::Organization]
    def organization
      @organization ||= Organization.new( @api )
    end

    # User apis
    #
    # @return [PritunlApiClient::User]
    def user
      @user ||= User.new( @api )
    end

    # Key apis
    #
    # @return [PritunlApiClient::Key]
    def key
      @key ||= Key.new( @api )
    end

    # Server apis
    #
    # @return [PritunlApiClient::Server]
    def server
      @server ||= Server.new( @api )
    end

  end
end

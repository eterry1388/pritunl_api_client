require_relative 'pritunl_api_client/settings'
require_relative 'pritunl_api_client/organization'
require_relative 'pritunl_api_client/user'
require_relative 'pritunl_api_client/key'
require_relative 'pritunl_api_client/server'

module PritunlApiClient
  class Client
    attr_reader :ip
    attr_reader :port
    attr_reader :username
    attr_reader :password
    attr_reader :secure

    def initialize( ip:, port: 9700, username:, password:, secure: false )
      @ip       = ip
      @port     = port
      @username = username
      @password = password
      @secure   = secure
      @api = Api.new( ip: ip, port: port, username: username, password: password, secure: secure )
    end

    def auth
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

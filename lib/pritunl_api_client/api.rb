require 'rest-client'
require 'json'

module PritunlApiClient
  class Api

    def initialize( ip:, port: 9700, username:, password:, secure: false )
      @client = RestClient::Resource.new( "http://#{ip}:#{port}" )
    end

    # Create
    def post( api, params = {} )
      JSON.parse @client[api].post( params )
    end

    # Read
    def get( api, params = {} )
      JSON.parse @client[api].get( params: params )
    end

    # Update
    def put( api, params = {} )
      JSON.parse @client[api].put( params )
    end

    # Delete
    def delete( api, params = {} )
      JSON.parse @client[api].delete( params: params )
    end

    # Metadata Information
    def head( api, params = {} )
      JSON.parse @client[api].head( params )
    end

  end
end

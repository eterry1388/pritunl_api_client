require 'rest-client'
require 'securerandom'
require 'base64'
require 'json'

module PritunlApiClient
  class Api

    def initialize( base_url:, api_token:, api_secret:, verify_ssl: true )
      @api_token = api_token
      @api_secret = api_secret
      @client = RestClient::Resource.new( base_url, verify_ssl: verify_ssl )
    end

    # Create
    def post( path, params = {} )
      parameters = common_params.merge( generate_auth_headers( path: path, params: params, method: 'POST' ) )
      JSON.parse @client[path].post( JSON.generate( params, space: ' ' ), parameters )
    end

    # Read
    def get( path, params = {} )
      parameters = { params: params }
      parameters.merge!( common_params )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'GET' ) )
      JSON.parse @client[path].get( parameters )
    end

    # Update
    def put( path, params = {} )
      parameters = common_params.merge( generate_auth_headers( path: path, params: params, method: 'PUT' ) )
      JSON.parse @client[path].put( JSON.generate( params, space: ' ' ), parameters )
    end

    # Delete
    def delete( path, params = {} )
      parameters = { params: params }
      parameters.merge!( common_params )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'DELETE' ) )
      JSON.parse @client[path].delete( parameters )
    end

    # Metadata Information
    def head( path, params = {} )
      parameters = common_params.merge( generate_auth_headers( path: path, params: params, method: 'HEAD' ) )
      JSON.parse @client[path].head( JSON.generate( params, space: ' ' ), parameters )
    end

    private

    def common_params
      { content_type: :json, accept: :json }
    end

    def generate_auth_headers( path:, params: {}, method: )
      auth_timestamp = Time.now.to_i
      auth_nonce = SecureRandom.hex( 16 )
      auth_string = [@api_token, auth_timestamp, auth_nonce, method, path]
      auth_string << JSON.generate( params, space: ' ' ) unless params.empty?
      auth_string = auth_string.join( '&' )
      digest = OpenSSL::Digest.new( 'sha256' )
      hmac = OpenSSL::HMAC.digest( digest, @api_secret, auth_string )
      auth_signature = Base64.encode64( hmac ).chomp
      {
        auth_token:     @api_token,
        auth_timestamp: auth_timestamp,
        auth_nonce:     auth_nonce,
        auth_signature: auth_signature
      }
    end

  end
end

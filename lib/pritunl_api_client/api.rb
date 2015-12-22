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
    def post( path, params = nil )
      headers = common_params.merge( generate_auth_headers( path: path, params: params, method: 'POST' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].post( params, headers )
    end

    # Read
    def get( path, params = nil )
      parameters = { params: params }
      parameters.merge!( common_params )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'GET' ) )
      parse_data @client[path].get( parameters )
    end

    # Update
    def put( path, params = nil )
      headers = common_params.merge( generate_auth_headers( path: path, params: params, method: 'PUT' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].put( params, headers )
    end

    # Delete
    def delete( path, params = nil )
      parameters = { params: params }
      parameters.merge!( common_params )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'DELETE' ) )
      parse_data @client[path].delete( parameters )
    end

    # Metadata Information
    def head( path, params = nil )
      headers = common_params.merge( generate_auth_headers( path: path, params: params, method: 'HEAD' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].head( params, headers )
    end

    private

    def common_params
      { content_type: :json, accept: :json }
    end

    def generate_auth_headers( path:, params: nil, method: )
      auth_timestamp = Time.now.to_i
      auth_nonce = SecureRandom.hex( 16 )
      auth_string = [@api_token, auth_timestamp, auth_nonce, method, path]
      auth_string << JSON.generate( params, space: ' ' ) if params
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

    def parse_data( data )
      JSON.parse( data )
    rescue JSON::ParserError => e
      data
    end

  end
end

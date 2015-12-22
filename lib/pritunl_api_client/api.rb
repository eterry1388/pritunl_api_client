require 'rest-client'
require 'securerandom'
require 'base64'
require 'json'

module PritunlApiClient

  # Low-level communication to api server
  class Api

    # @param base_url [String] Full URL to a running Pritunl server (include the "https://")
    # @param api_token [String
    # @param api_secret [String]
    # @param verify_ssl [Boolean] Whether or not to verify SSL certificate]
    def initialize( base_url:, api_token:, api_secret:, verify_ssl: true )
      @api_token = api_token
      @api_secret = api_secret
      @client = RestClient::Resource.new( base_url, verify_ssl: verify_ssl )
    end

    # Send post request to api server
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @return [Hash, Array, String] Response from api server
    def post( path, params = nil )
      headers = common_headers.merge( generate_auth_headers( path: path, params: params, method: 'POST' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].post( params, headers )
    end

    # Send get request to api server
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @return [Hash, Array, String] Response from api server
    def get( path, params = nil )
      parameters = { params: params }
      parameters.merge!( common_headers )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'GET' ) )
      parse_data @client[path].get( parameters )
    end

    # Send put request to api server
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @return [Hash, Array, String] Response from api server
    def put( path, params = nil )
      headers = common_headers.merge( generate_auth_headers( path: path, params: params, method: 'PUT' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].put( params, headers )
    end

    # Send delete request to api server
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @return [Hash, Array, String] Response from api server
    def delete( path, params = nil )
      parameters = { params: params }
      parameters.merge!( common_headers )
      parameters.merge!( generate_auth_headers( path: path, params: params, method: 'DELETE' ) )
      parse_data @client[path].delete( parameters )
    end

    # Send head request to api server
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @return [Hash, Array, String] Response from api server
    def head( path, params = nil )
      headers = common_headers.merge( generate_auth_headers( path: path, params: params, method: 'HEAD' ) )
      params = JSON.generate( params, space: ' ' ) if params
      parse_data @client[path].head( params, headers )
    end

    private

    # Common headers to add to every request
    #
    # @return [Hash]
    def common_headers
      { content_type: :json, accept: :json }
    end

    # Authentication algorithm that is included in every request
    #
    # @param path [String] URL path of api
    # @param params [Hash, NilClass] Api parameters
    # @param method [String] Uppercase method for the request
    # @return [Hash]
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

    # Parse responses back from api server
    #
    # @param data [String]
    # @return [Hash, Array, String]
    def parse_data( data )
      JSON.parse( data )
    rescue JSON::ParserError => e
      data
    end

  end
end

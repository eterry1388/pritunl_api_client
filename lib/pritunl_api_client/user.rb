module PritunlApiClient

  # Interact with /user api's
  class User

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Returns a list of users in an organization
    #
    # @param organization_id [String]
    # @return [Array]
    def all( organization_id: )
      @api.get( "/user/#{organization_id}" )
    end

    # Returns a user from an organization
    #
    # @param id [String] User ID
    # @param organization_id [String]
    # @return [Hash]
    def find( id, organization_id: )
      @api.get( "/user/#{organization_id}/#{id}" )
    end

    # Create a new user in an organization. An array of users can be sent for bulk adding users
    #
    # @param params [Hash, Array]
    # @raise [ArgumentError] if params is not a Hash or an Array
    # @raise [ArgumentError] if organization_id is not passed into the parameter list
    # @return [Hash, Array]
    def create( params )
      fail ArgumentError, 'params must be a Hash or an Array' unless ( params.is_a?( Hash ) || params.is_a?( Array ) )
      fail ArgumentError, '"organization_id" is a required parameter' unless params.keys.include? :organization_id
      organization_id = params.delete( :organization_id )
      @api.post( "/user/#{organization_id}", params )
    end

    # Update an existing user in an organization
    #
    # @param id [String] User ID
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @raise [ArgumentError] if organization_id is not passed into the parameter list
    # @return [Hash]
    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      fail ArgumentError, '"organization_id" is a required parameter' unless params.keys.include? :organization_id
      organization_id = params.delete( :organization_id )
      @api.put( "/user/#{organization_id}/#{id}", params )
    end

    # Delete an existing user in an organization, this will disconnect the user
    #
    # @param id [String] User ID
    # @param organization_id [String]
    def delete( id, organization_id: )
      @api.delete( "/user/#{organization_id}/#{id}" )
    end

    # Generate a new two-step authentication secret for an existing user
    #
    # @param id [String] User ID
    # @param organization_id [String]
    # @return [Hash]
    def otp_secret( id, organization_id: )
      @api.put( "/user/#{organization_id}/#{id}/otp_secret" )
    end

  end
end

module PritunlApiClient
  
  # Interact with /organization api's
  class Organization

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Returns a list of organizations on the server
    #
    # @return [Array]
    def all
      @api.get( '/organization' )
    end

    # Returns an organization
    #
    # @param id [String] Organization ID
    # @return [Hash]
    def find( id )
      @api.get( "/organization/#{id}" )
    end

    # Create a new organization
    #
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @return [Hash]
    def create( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.post( '/organization', params )
    end

    # Modify an existing organization
    #
    # @param id [String] Organization ID
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @return [Hash]
    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( "/organization/#{id}", params )
    end

    # Delete an existing organization
    #
    # @param id [String] Organization ID
    def delete( id )
      @api.delete( "/organization/#{id}" )
    end

  end
end

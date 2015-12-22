module PritunlApiClient

  # Interact with /server api's
  class Server

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Returns a list of servers
    #
    # @return [Array]
    def all
      @api.get( '/server' )
    end

    # Returns a server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def find( id )
      @api.get( "/server/#{id}" )
    end

    # Create a new server
    #
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @return [Hash]
    def create( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.post( '/server', params )
    end

    # Update an existing server
    #
    # @param id [String] Server ID
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @return [Hash]
    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( "/server/#{id}", params )
    end

    # Delete an existing server
    #
    # @param id [String] Server ID
    def delete( id )
      @api.delete( "/server/#{id}" )
    end

    # Start an existing server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def start( id )
      @api.put( "/server/#{id}/start" )
    end

    # Stop an existing server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def stop( id )
      @api.put( "/server/#{id}/stop" )
    end

    # Restart an existing server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def restart( id )
      @api.put( "/server/#{id}/restart" )
    end

    # Returns a list of organizations attached to a server
    #
    # @param id [String] Server ID
    # @return [Array]
    def organizations( id )
      @api.get( "/server/#{id}/organization" )
    end

    # Attach an organization to an existing server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def attach_organization( id, organization_id: )
      @api.put( "/server/#{id}/organization/#{organization_id}" )
    end

    # Remove an organization from an existing server
    #
    # @param id [String] Server ID
    def remove_organization( id, organization_id: )
      @api.delete( "/server/#{id}/organization/#{organization_id}" )
    end

    # Get the output of a server
    #
    # @param id [String] Server ID
    # @return [Hash]
    def output( id )
      @api.get( "/server/#{id}/output" )
    end

    # Clear the output of a server
    #
    # @param id [String] Server ID
    def clear_output( id )
      @api.delete( "/server/#{id}/output" )
    end

  end
end

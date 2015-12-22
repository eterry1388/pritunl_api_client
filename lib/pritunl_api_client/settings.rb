module PritunlApiClient

  # Interact with /settings api's
  class Settings

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Get system settings
    #
    # @return [Array]
    def all
      @api.get( '/settings' )
    end

    # Change the system settings
    #
    # @param params [Hash]
    # @raise [ArgumentError] if params is not a Hash
    # @return [Hash]
    def update( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( '/settings', params )
    end

  end
end

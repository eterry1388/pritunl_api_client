module PritunlApiClient
  class Settings

    def initialize( api )
      @api = api
    end

    def all
      @api.get( '/settings' )
    end

    def update( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( '/settings', params )
    end

  end
end

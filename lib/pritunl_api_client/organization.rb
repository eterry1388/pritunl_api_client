module PritunlApiClient
  class Organization

    def initialize( api )
      @api = api
    end

    def all
      @api.get( '/organization' )
    end

    def find( id )
      @api.get( "/organization/#{id}" )
    end

    def create( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.post( '/organization', params )
    end

    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( "/organization/#{id}", params )
    end

    def delete( id )
      @api.delete( "/organization/#{id}" )
    end

  end
end

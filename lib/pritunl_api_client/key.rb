module PritunlApiClient
  class Key

    def initialize( api )
      @api = api
    end

    def all( organization_id: )
      @api.get( "/user/#{organization_id}" )
    end

    def find( id, organization_id: )
      @api.get( "/user/#{organization_id}/#{id}" )
    end

    def create( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      fail ArgumentError, '"organization_id" is a required parameter' unless params.keys.include? :organization_id
      organization_id = params.delete( :organization_id )
      @api.post( "/user/#{organization_id}", params )
    end

    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      fail ArgumentError, '"organization_id" is a required parameter' unless params.keys.include? :organization_id
      organization_id = params.delete( :organization_id )
      @api.put( "/user/#{organization_id}/#{id}", params )
    end

    def delete( id, organization_id: )
      @api.delete( "/user/#{organization_id}/#{id}" )
    end

  end
end

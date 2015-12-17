module PritunlApiClient
  class Organization

    def initialize( api )
      @api = api
    end

    def all
      @api.get( "/organization" )
    end

    def find( id )
      @api.get( "/organization/#{id}" )
    end

    def create( name: )
      @api.post( "/organization", name: name )
    end

    def update( id, name: )
      @api.put( "/organization/#{id}", name: name )
    end

    def delete( id )
      @api.delete( "/organization/#{id}" )
    end

  end
end

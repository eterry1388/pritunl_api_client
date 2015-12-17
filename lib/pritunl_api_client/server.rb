module PritunlApiClient
  class Server

    def initialize( api )
      @api = api
    end

    def all
      @api.get( '/organization' )
    end

    def find( organization_id )
      @api.get( "/organization/#{organization_id}" )
    end

  end
end

module PritunlApiClient
  class Server

    def initialize( api )
      @api = api
    end

    def all
      @api.get( '/server' )
    end

    def find( id )
      @api.get( "/server/#{id}" )
    end

    def create( params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.post( '/server', params )
    end

    def update( id, params )
      fail ArgumentError, 'params must be a Hash' unless params.is_a? Hash
      @api.put( "/server/#{id}", params )
    end

    def delete( id )
      @api.delete( "/server/#{id}" )
    end

    def start( id )
      @api.put( "/server/#{id}/start" )
    end

    def stop( id )
      @api.put( "/server/#{id}/stop" )
    end

    def restart( id )
      @api.put( "/server/#{id}/restart" )
    end

    def organizations( id )
      @api.get( "/server/#{id}/organization" )
    end

    def attach_organization( id, organization_id: )
      @api.put( "/server/#{id}/organization/#{organization_id}" )
    end

    def remove_organization( id, organization_id: )
      @api.delete( "/server/#{id}/organization/#{organization_id}" )
    end

    def output( id )
      @api.get( "/server/#{id}/output" )
    end

    def clear_output( id )
      @api.delete( "/server/#{id}/output" )
    end

  end
end

module PritunlApiClient
  class Key

    def initialize( api )
      @api = api
    end

    def download_tar( organization_id:, user_id:, path: )
      data = @api.get( "/key/#{organization_id}/#{user_id}.tar" )
      File.write( path, data )
      path
    end

    def download_zip( organization_id:, user_id:, path: )
      data = @api.get( "/key_onc/#{organization_id}/#{user_id}.zip" )
      File.write( path, data )
      path
    end

    def temporary_url( organization_id:, user_id: )
      @api.get( "/key/#{organization_id}/#{user_id}" )
    end

  end
end

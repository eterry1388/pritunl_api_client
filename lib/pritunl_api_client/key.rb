module PritunlApiClient

  # Interact with /key api's
  class Key

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Download a users key tar archive
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file
    # @return [String] Local path to downloaded file
    def download_tar( organization_id:, user_id:, path: )
      data = @api.get( "/key/#{organization_id}/#{user_id}.tar" )
      File.write( path, data )
      path
    end

    # Download a users onc key zip archive
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file
    # @return [String] Local path to downloaded file
    def download_zip( organization_id:, user_id:, path: )
      data = @api.get( "/key_onc/#{organization_id}/#{user_id}.zip" )
      File.write( path, data )
      path
    end

    # Generate a temporary url to download a users key archive 
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @return [Hash]
    def temporary_url( organization_id:, user_id: )
      @api.get( "/key/#{organization_id}/#{user_id}" )
    end

  end
end

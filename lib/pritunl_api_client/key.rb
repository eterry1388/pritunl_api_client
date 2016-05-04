module PritunlApiClient

  # Interact with /key api's
  class Key

    # @param api [PritunlApiClient::Api]
    def initialize( api )
      @api = api
    end

    # Download a users key
    #
    # @note User organization must be attached to a server AND user must be enabled and NOT connected!
    # @deprecated This method of downloading the OVPN file is not reliable. Use {#download_tar} or {#download_zip} instead.
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file (if omitted, file content fill be returned)
    # @raise [StandardError] if user or servers cannot be found
    # @return [String] Local path to downloaded file or file contents if 'path' was omitted
    def download( organization_id:, user_id:, path: nil )
      temporary_url_id = temporary_url( organization_id: organization_id, user_id: user_id )['id']
      all_users = @api.get( "/user/#{organization_id}" )
      user = all_users.find { |user| user['id'] == user_id }
      fail StandardError, 'Could not find user!' unless user
      servers = user['servers']
      fail StandardError, 'Could not find servers attached to user!' unless servers && servers.count >= 1
      server_id = servers.first['id']
      data = @api.get( "/key/#{temporary_url_id}/#{server_id}.key" )
      return data unless path
      File.write( path, data.force_encoding( 'utf-8' ) )
      path
    end

    # Download a users key tar archive
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file (if omitted, file content fill be returned)
    # @return [String] Local path to downloaded file or file contents if 'path' was omitted
    def download_tar( organization_id:, user_id:, path: nil )
      data = @api.get( "/key/#{organization_id}/#{user_id}.tar" )
      return data unless path
      File.write( path, data.force_encoding( 'utf-8' ) )
      path
    end

    # Download a users key zip archive
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file (if omitted, file content fill be returned)
    # @return [String] Local path to downloaded file or file contents if 'path' was omitted
    def download_zip( organization_id:, user_id:, path: nil )
      data = @api.get( "/key/#{organization_id}/#{user_id}.zip" )
      return data unless path
      File.write( path, data.force_encoding( 'utf-8' ) )
      path
    end

    # Download a users onc key (Chromebook profile) as a zip archive
    #
    # @param organization_id [String]
    # @param user_id [String]
    # @param path [String] Local path to save downloaded file (if omitted, file content fill be returned)
    # @return [String] Local path to downloaded file or file contents if 'path' was omitted
    def download_chromebook_profile( organization_id:, user_id:, path: nil )
      data = @api.get( "/key_onc/#{organization_id}/#{user_id}.zip" )
      return data unless path
      File.write( path, data.force_encoding( 'utf-8' ) )
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

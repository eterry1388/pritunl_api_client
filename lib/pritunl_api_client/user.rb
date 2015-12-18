module PritunlApiClient
  class User

    def initialize( api )
      @api = api
    end

    def all( organization_id: )
      @api.get( "/user/#{organization_id}" )
    end

    def find( id, organization_id: )
      @api.get( "/user/#{organization_id}/#{id}" )
    end

    def create( organization_id:, name:, email:, disabled: )
      @api.post( "/user/#{organization_id}", name: name, email: email, disabled: disabled )
    end

    def update( id, organization_id:, name:, email:, disabled: )
      @api.put( "/user/#{organization_id}/#{id}", name: name, email: email, disabled: disabled )
    end

    def delete( id, organization_id: )
      @api.delete( "/user/#{organization_id}/#{id}" )
    end

    # @note Currently not working
    # @see https://github.com/pritunl/pritunl/issues/212
    def otp_secret( id, organization_id: )
      @api.put( "/user/#{organization_id}/#{id}/otp_secret" )
    end

  end
end

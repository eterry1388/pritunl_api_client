require 'spec_helper'

# NOTE: These specs are not unit tests, but rather system tests
# that require a live system to run against.  The BASE_URL,
# API_TOKEN, and API_SECRET environment variables need to be
# set before these tests will run.

describe PritunlApiClient do
  
  before :all do
    @pritunl = PritunlApiClient::Client.new(
      base_url:   @base_url,
      api_token:  @api_token,
      api_secret: @api_secret,
      verify_ssl: false
    )
  end

  it 'Ping server' do
    expect { @pritunl.ping }.to_not raise_error
  end

  it 'Get server status' do
    expect { @pritunl.status }.to_not raise_error
  end

  it 'Get logs' do
    expect { @pritunl.log }.to_not raise_error
  end

  it 'Get events' do
    expect { @pritunl.event( cursor: 'admin_auth' ) }.to_not raise_error
  end

  describe PritunlApiClient::Organization do
    it 'Create organization' do
      begin
        expect { @org = create_organization }.to_not raise_error
      ensure
        @pritunl.organization.delete( @org['id'] ) if @org
      end
    end

    it 'Find organization' do
      org = create_organization
      begin
        expect { @pritunl.organization.find( org['id'] ) }.to_not raise_error
      ensure
        @pritunl.organization.delete( org['id'] )
      end
    end

    it 'Update organization' do
      org = create_organization
      begin
        expect { @pritunl.organization.update( org['id'], name: 'test-org-renamed' ) }.to_not raise_error
      ensure
        @pritunl.organization.delete( org['id'] )
      end
    end

    it 'Get all organizations' do
      org = create_organization
      begin
        expect { @pritunl.organization.all }.to_not raise_error
      ensure
        @pritunl.organization.delete( org['id'] )
      end
    end

    it 'Delete organization' do
      org = create_organization
      expect { @pritunl.organization.delete( org['id'] ) }.to_not raise_error
    end
  end

  describe PritunlApiClient::User do
    before :all do
      @org = create_organization
    end

    after :all do
      @pritunl.organization.delete( @org['id'] ) if @org
    end

    it 'Create user' do
      begin
        expect do
          @user = create_user( @org['id'] )
        end.to_not raise_error
      ensure
        @pritunl.user.delete( @user['id'], organization_id: @org['id'] ) if @user
      end
    end

    it 'Find user' do
      user = create_user( @org['id'] )
      begin
        expect { @pritunl.user.find( user['id'], organization_id: @org['id'] ) }.to_not raise_error
      ensure
        @pritunl.user.delete( user['id'], organization_id: @org['id'] ) if user
      end
    end

    it 'Update user' do
      user = create_user( @org['id'] )
      begin
        expect do
          @pritunl.user.update( user['id'],
            organization_id: @org['id'],
            name: 'test-user-renamed',
            email: 'test.user.renamed@example.com',
            disabled: false
          )
        end.to_not raise_error
      ensure
        @pritunl.user.delete( user['id'], organization_id: @org['id'] ) if user
      end
    end

    it 'Get all users' do
      user = create_user( @org['id'] )
      begin
        expect { @pritunl.user.all( organization_id: @org['id'] ) }.to_not raise_error
      ensure
        @pritunl.user.delete( user['id'], organization_id: @org['id'] ) if user
      end
    end

    it 'Generate two-step auth for user' do
      user = create_user( @org['id'] )
      begin
        expect { @pritunl.user.otp_secret( user['id'], organization_id: @org['id'] ) }.to_not raise_error
      ensure
        @pritunl.user.delete( user['id'], organization_id: @org['id'] ) if user
      end
    end

    it 'Delete user' do
      user = create_user( @org['id'] )
      expect { @pritunl.user.delete( user['id'], organization_id: @org['id'] ) }.to_not raise_error
    end
  end

  describe PritunlApiClient::Key do
    before :all do
      @org = create_organization
      @user = create_user( @org['id'] )
    end

    after :all do
      @pritunl.user.delete( @user['id'], organization_id: @org['id'] ) if @user && @org
      @pritunl.organization.delete( @org['id'] ) if @org
    end

    it 'Get tar key' do
      begin
        expect { @pritunl.key.download_tar( organization_id: @org['id'], user_id: @user['id'], path: 'output.tar' ) }.to_not raise_error
      ensure
        File.delete( 'output.tar' )
      end
    end

    it 'Get zip key' do
      begin
        expect { @pritunl.key.download_zip( organization_id: @org['id'], user_id: @user['id'], path: 'output.zip' ) }.to_not raise_error
      ensure
        File.delete( 'output.zip' )
      end
    end

    it 'Get key temporary url' do
      expect { @pritunl.key.temporary_url( organization_id: @org['id'], user_id: @user['id'] ) }.to_not raise_error
    end
  end

  describe PritunlApiClient::Server do
    it 'Create server' do
      begin
        expect do
          @server = create_server
        end.to_not raise_error
      ensure
        @pritunl.server.delete( @server['id'] ) if @server
      end
    end

    it 'Find server' do
      server = create_server
      begin
        expect { @pritunl.server.find( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
      end
    end

    it 'Get all servers' do
      server = create_server
      begin
        expect { @pritunl.server.all }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
      end
    end

    it 'Update server' do
      server = create_server
      begin
        expect { @pritunl.server.update( server['id'], name: 'server1-rename', dns_servers: ['8.8.8.8', '8.8.4.4'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
      end
    end

    it 'Attach organization' do
      server = create_server
      org = create_organization
      begin
        expect { @pritunl.server.attach_organization( server['id'], organization_id: org['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Get all organizations on server' do
      server = create_server
      org = create_organization
      begin
        @pritunl.server.attach_organization( server['id'], organization_id: org['id'] )
        expect { @pritunl.server.organizations( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Remove organization' do
      server = create_server
      org = create_organization
      begin
        @pritunl.server.attach_organization( server['id'], organization_id: org['id'] )
        expect { @pritunl.server.remove_organization( server['id'], organization_id: org['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Start server' do
      server = create_server
      org = create_organization
      begin
        wait_until_server_is_fully_created( server['id'] )
        @pritunl.server.attach_organization( server['id'], organization_id: org['id'] )
        expect { @pritunl.server.start( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Restart server' do
      server = create_server
      org = create_organization
      begin
        wait_until_server_is_fully_created( server['id'] )
        @pritunl.server.attach_organization( server['id'], organization_id: org['id'] )
        @pritunl.server.start( server['id'] )
        expect { @pritunl.server.restart( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Stop server' do
      server = create_server
      org = create_organization
      begin
        wait_until_server_is_fully_created( server['id'] )
        @pritunl.server.attach_organization( server['id'], organization_id: org['id'] )
        @pritunl.server.start( server['id'] )
        expect { @pritunl.server.stop( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
        @pritunl.organization.delete( org['id'] ) if org
      end
    end

    it 'Get server output' do
      server = create_server
      begin
        expect { @pritunl.server.output( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
      end
    end

    it 'Clear server output' do
      server = create_server
      begin
        expect { @pritunl.server.clear_output( server['id'] ) }.to_not raise_error
      ensure
        @pritunl.server.delete( server['id'] ) if server
      end
    end
  end

  describe PritunlApiClient::Settings do
    it 'Get all settings' do
      expect { @pritunl.settings.all }.to_not raise_error
    end

    it 'Update settings' do
      settings = @pritunl.settings.all
      begin
        expect do
          @pritunl.settings.update( theme: 'light' )
        end.to_not raise_error
      ensure
        @pritunl.settings.update( theme: settings['theme'] )
      end
    end
  end
end

# Helper methods

def create_organization
  @pritunl.organization.create( name: 'test-org' )
end

def create_user( org_id )
  @pritunl.user.create(
    organization_id: org_id,
    name: 'test-user',
    email: 'test.user@example.com',
    disabled: true
  )
end

def create_server
  @pritunl.server.create(
    name: 'server1',
    network: '10.11.6.0/24',
    port: 12533,
    protocol: 'udp',
    mode: 'all_traffic',
    network_mode: 'tunnel',
    network_start: nil,
    network_end: nil,
    multi_device: false,
    local_networks: [],
    dns_servers: ['8.8.4.4'],
    inter_client: true,
    ping_interval: 10,
    ping_timeout: 60,
    max_clients: 2048,
    replica_count: 1,
    debug: false
  )
end

def wait_until_server_is_fully_created( server_id )
  Timeout::timeout( 30 ) do
    loop do
      result = @pritunl.server.find( server_id )
      break if result['status'] != 'pending'
      sleep 3
    end
  end
end

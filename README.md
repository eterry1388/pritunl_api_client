# Pritunl API Client

[![Gem Version](https://badge.fury.io/rb/pritunl_api_client.svg)](https://badge.fury.io/rb/pritunl_api_client)
![](http://ruby-gem-downloads-badge.herokuapp.com/pritunl_api_client?type=total)
[![Inline docs](http://inch-ci.org/github/eterry1388/pritunl_api_client.svg?branch=master)](http://inch-ci.org/github/eterry1388/pritunl_api_client)
[![Dependency Status](https://gemnasium.com/eterry1388/pritunl_api_client.svg)](https://gemnasium.com/eterry1388/pritunl_api_client)

API client for Pritunl written in Ruby.

[Pritunl](https://github.com/pritunl/pritunl) is a distributed enterprise
vpn server built using the OpenVPN protocol. See the official Pritunl API
documentation here: https://pritunl.com/api.html.  I am not affiliated with
Pritunl.

## Installation

```bash
gem install pritunl_api_client
```

## Usage

```ruby
require 'pritunl_api_client'

@pritunl = PritunlApiClient::Client.new(
  base_url:   'https://localhost:9700',
  api_token:  'p7g444S3IZ5wmFvmzWmx14qACXdzQ25b',
  api_secret: 'OpS9fjxkPI3DclkdKDDr6mqYVd0DJh4i',
  verify_ssl: false
)
```

## Ping

### Server healthcheck.

```ruby
@pritunl.ping
```

## Status

### Returns general information about the pritunl server.

```ruby
@pritunl.status

{
  "host_count" => 1,
  "servers_online" => 1,
  "hosts_online" => 1,
  "server_count" => 2,
  "server_version" => "1.11.813.26",
  "public_ip" => "10.55.87.4",
  "user_count" => 1,
  "notification" => "",
  "users_online" => 1,
  "local_networks" => ["10.55.87.3/31", "10.2.214.0/31"],
  "current_host" => "0f273a6c32ed45259c1ecb1ec3ac05ce",
  "org_count" => 2
}
```

## Log

### Returns a list of server log entries sorted by time.

```ruby
@pritunl.log

[
  {
    "timestamp" => 1450429682,
    "message" => "Deleted organization 'org1'.",
    "id" => "567386a32221390ea53d8047"
  },
  {
    "timestamp" => 1450429682,
    "message" => "Deleted user 'user1'.",
    "id" => "567386a32221390ea53d8045"
  },
  {
    "timestamp" => 1450429681,
    "message" => "Enabled user 'user2'.",
    "id" => "567386a22221390ea53d8042"
  }
]
```

## Events

### Get a list of events (will poll up to 30 seconds)

```ruby
@pritunl.event( cursor: '55e9f1f1b0e730245677dc31' )

[
  {
      "id" => "55e9f1f1b0e730245677dc31",
      "type" => "users_updated",
      "timestamp" => 1388495793,
      "resource_id" => "55e9f1f8b0e730245677dc34"
  },
  {
      "id" => "55e9f1f2b0e730245677dc32",
      "type" => "server_organizations_updated",
      "timestamp" => 1388495805,
      "resource_id" => "55e9f1f8b0e730245677dc33"
  }
]
```

## Settings

### Get system settings.

```ruby
@pritunl.settings.all

{
  "username" => "user6",
  "sso_admin" => nil,
  "theme" => "dark",
  "sso" => nil,
  "sso_match" => nil,
  "server_cert" => "-----BEGIN CERTIFICATE----------END CERTIFICATE-----",
  "public_address" => "10.5.8.46",
  "routed_subnet6" => nil,
  "email_username" => "user1",
  "sso_saml_issuer_url" => nil,
  "sso_saml_cert" => nil,
  "sso_token" => nil,
  "email_password" => true,
  "sso_onelogin_key" => nil,
  "email_server" => "smtp.example.com",
  "auditing" => nil,
  "sso_secret" => nil,
  "server_key" => "-----BEGIN PRIVATE KEY----------END PRIVATE KEY-----",
  "default" => nil,
  "sso_host" => nil,
  "public_address6" => "2605:1480:2:a210::1",
  "secret" => "9D1ZJTscrr2mK4Xnxw76ltmpwnH7udeO",
  "sso_okta_token" => nil,
  "sso_saml_url" => nil,
  "token" => "UQRM0R3bsXDpy3p6nqtjfrbjujSadaAx",
  "sso_org" => nil,
  "email_from" => "first.last@example.com"
}
```

### Change the system settings.

```ruby
@pritunl.settings.update( theme: 'dark' )

@pritunl.settings.update(
  email_username: 'user1',
  email_password: '12345',
  email_server:   'smtp.example.com',
  email_from:     'first.last@example.com'
)
```

## Users

### Returns a list of users in an organization sorted by name.

```ruby
@pritunl.user.all( organization_id: org['id'] )

[
  {
    "auth_type" => "local",
    "status" => false,
    "dns_servers" => nil,
    "otp_secret" => "OPT4HTURJTW6JLQN",
    "dns_mapping" => nil,
    "dns_suffix" => nil,
    "servers" => [
      {
        "status" => false,
        "platform" => nil,
        "server_id" => "567369be2231390ea53d76d4",
        "local_address" => "10.139.82.6",
        "remote_address" => "10.139.82.7",
        "virt_address6" => "fd00:c0a8:e800:0:10.139.82.6",
        "virt_address" => "10.139.82.6",
        "name" => "server1",
        "real_address" => "8.8.8.8:41536",
        "connected_since" => 1388498640,
        "id" => "55e9f995b0e73033d45b44da",
        "device_name" => nil
      }
    ],
    "disabled" => false,
    "network_links" => [],
    "sso" => nil,
    "bypass_secondary" => false,
    "id" => "55e9f98cb0e73033d45b44d7",
    "audit" => false,
    "name" => "user0",
    "organization_name" => "org1",
    "gravatar" => true,
    "otp_auth" => false,
    "organization" => "55e9f7c7b0e73033d45b44d4",
    "type" => "client",
    "email" => "user0@example.com"
  }
]
```

### Returns a user from an organization.

```ruby
@pritunl.user.find( user['id'], organization_id: org['id'] )

{
  "auth_type" => "local",
  "dns_servers" => nil,
  "otp_secret" => "OPT4HTURJTW6JLQN",
  "dns_suffix" => nil,
  "disabled" => true,
  "bypass_secondary" => false,
  "id" => "55e9f98cb0e73033d45b44d7",
  "name" => "user0",
  "organization_name" => "org1",
  "organization" => "55e9f7c7b0e73033d45b44d4",
  "type" => "client",
  "email" => "user0@example.com"
}
```

### Create a new user in an organization. An array of users can be sent for bulk adding users.

```ruby
@pritunl.user.create(
  organization_id: org['id'],
  name: 'new_user',
  email: 'new_user@example.com',
  disabled: true
)
```

### Rename or disabled an existing user in an organization. Disabling will also disconnect the user.

```ruby
@pritunl.user.update( user['id'],
  organization_id: org['id'],
  name: 'new_name',
  email: 'new_email@example.com',
  disabled: false
)
```

### Delete an existing user in an organization, this will disconnect the user.

```ruby
@pritunl.user.delete( user['id'], organization_id: org['id'] )
```

### Generate a new two-step authentication secret for an existing user.

```ruby
@pritunl.user.otp_secret( user['id'], organization_id: org['id'] )
```

## Organizations

### Returns a list of organizations on the server sorted by name.

```ruby
@pritunl.organization.all

[
  {
    "user_count" => 512,
    "id" => "55e99499b0e7300fef77e2b1",
    "name" => "org1"
  },
  {
    "user_count" => 1024,
    "id" => "55e9f1d4b0e730245677dc2d",
    "name" => "org2"
  }
]
```

### Returns an organization.

```ruby
@pritunl.organization.find( org['id'] )

{
  "user_count" => 512,
  "id" => "55e99499b0e7300fef77e2b1",
  "name" => "org1"
}
```

### Create a new organization.

```ruby
@pritunl.organization.create( name: 'new_org' )
```

### Rename an existing organization.

```ruby
@pritunl.organization.update( org['id'], name: 'new_name' )
```

### Delete an existing organization.

```ruby
@pritunl.organization.delete( org['id'] )
```

## Keys

If you omit the `path` parameter on any of the `key` APIs below, the file content will be directly returned
from the method rather than to a downloaded file.

### Download a users key.

```ruby
@pritunl.key.download( organization_id: org['id'], user_id: user['id'], path: 'output.ovpn' )
```

### Download a users key tar archive.

```ruby
@pritunl.key.download_tar( organization_id: org['id'], user_id: user['id'], path: 'output.tar' )
```

### Download a users key zip archive.

```ruby
@pritunl.key.download_zip( organization_id: org['id'], user_id: user['id'], path: 'output.zip' )
```

### Download a users onc key Chromebook profile zip archive.

```ruby
@pritunl.key.download_chromebook_profile( organization_id: org['id'], user_id: user['id'], path: 'output.zip' )
```

### Generate a temporary url to download a users key archive.

```ruby
@pritunl.key.temporary_url( organization_id: org['id'], user_id: user['id'] )

{
  "view_url" => "/k/MjyaVvGk",
  "key_url" => "/key/4f5bd04d85414e20b0a451d642dab06d.tar",
  "uri_url" => "/ku/MjyaVvGk",
  "key_zip_url" => "/key/4f5bd04d85414e20b0a451d642dab06d.zip",
  "key_onc_url" => "/key_onc/4f5bd04d85414e20b0a451d642dab06d.zip",
  "id" => "4f5bd04d85414e20b0a451d642dab06d"
}
```

## Servers

### Returns a list of servers.

```ruby
@pritunl.server.all
```

### Returns a server.

```ruby
@pritunl.server.find( server['id'] )

{
  "status" => "pending",
  "lzo_compression" => false,
  "dns_servers" => ["8.8.4.4"],
  "protocol" => "udp",
  "ping_interval" => 10,
  "dns_mapping" => false,
  "network_mode" => "tunnel",
  "debug" => false,
  "network_end" => nil,
  "bind_address" => nil,
  "link_ping_interval" => 1,
  "hash" => "sha1",
  "ipv6_firewall" => true,
  "inter_client" => true,
  "id" => "5678d5286231390ea53eda96",
  "network_start" => nil,
  "network" => "10.11.6.0/24",
  "local_networks" => [],
  "uptime" => nil,
  "user_count" => 0,
  "name" => "server1",
  "dh_param_bits" => 2048,
  "max_clients" => 2048,
  "users_online" => 0,
  "replica_count" => 1,
  "link_ping_timeout" => 5,
  "port" => 12533,
  "devices_online" => 0,
  "ping_timeout" => 60,
  "mode" => "all_traffic",
  "ipv6" => false,
  "otp_auth" => false,
  "jumbo_frames" => false,
  "multi_device" => false,
  "search_domain" => "example.com",
  "cipher" => "aes256"
}
```

### Create a new server.

```ruby
@pritunl.server.create(
  name: 'server1',
  network: '10.11.6.0/24',
  bind_address: nil,
  port: 12533,
  protocol: 'udp',
  dh_param_bits: 2048,
  mode: 'all_traffic',
  network_mode: 'tunnel',
  network_start: nil,
  network_end: nil,
  multi_device: false,
  local_networks: [],
  dns_servers: ['8.8.4.4'],
  search_domain: 'pritunl.com',
  otp_auth: false,
  cipher: 'aes256',
  jumbo_frames: false,
  lzo_compression: false,
  inter_client: true,
  ping_interval: 10,
  ping_timeout: 60,
  max_clients: 2048,
  replica_count: 1,
  debug: false
)
```

### Update an existing server.

```ruby
@pritunl.server.update( server['id'], name: 'server1-rename', dns_servers: ['8.8.8.8', '8.8.4.4'] )
```

### Delete an existing server.

```ruby
@pritunl.server.delete( server['id'] )
```

### Start, stop or restart an existing server.

```ruby
@pritunl.server.start( server['id'] )
@pritunl.server.stop( server['id'] )
@pritunl.server.restart( server['id'] )
```

### Returns a list of organizations attached to a server.

```ruby
@pritunl.server.organizations( server['id'] )

[
  {
    "id" => "5678d0f48831390da53ef8ae",
    "name" => "org1",
    "server" => "5678d5286231390ea53eda96"
  },
  {
    "id" => "5678d0f48831392ba71ad3cb",
    "name" => "org2",
    "server" => "5678d5286231390ea53eda96"
  }
]
```

### Attach an organization to an existing server.

```ruby
@pritunl.server.attach_organization( server['id'], organization_id: org['id'] )

{
  "id" => "5678d0f48831390da53ef8ae",
  "name" => "org1",
  "server" => "5678d5286231390ea53eda96"
}
```

### Remove an organization from an existing server.

```ruby
@pritunl.server.remove_organization( server['id'], organization_id: org['id'] )
```

### Get the output of a server.

```ruby
@pritunl.server.output( server['id'] )

{
  "id" => "5678d5286231390ea53eda96",
  "output" => [
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 OpenVPN 2.3.2 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [eurephia] [MH] [IPv6] built on Dec  1 2014",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 Control Channel Authentication: tls-auth using INLINE static key file",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 TUN/TAP device tun11 opened",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 do_ifconfig, tt->ipv6=0, tt->did_ifconfig_ipv6_setup=0",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 /sbin/ip link set dev tun11 up mtu 1500",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 /sbin/ip addr add dev tun11 10.11.6.1/24 broadcast 10.11.6.255",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 UDPv4 link local (bound): [undef]",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 UDPv4 link remote: [undef]",
    "[patient-forest-4024] Mon Dec 21 23:45:15 2015 Initialization Sequence Completed"
  ]
}
```

### Clear the output of a server.

```ruby
@pritunl.server.clear_output( server['id'] )
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eterry1388/pritunl_api_client.  Please make sure
all tests pass before making a pull request.  The tests are system tests (not unit tests), so please have a live Pritunl
server up and running when executing the tests.

### How to run system tests

```bash
BASE_URL='https://your-ip-address:9700' API_TOKEN='your-api-token' API_SECRET='your-api-secret' rspec
```

The output should look something like this:

```
PritunlApiClient
  Ping server
  Get server status
  Get logs
  Get events
  PritunlApiClient::Organization
    Create organization
    Find organization
    Update organization
    Get all organizations
    Delete organization
  PritunlApiClient::User
    Create user
    Find user
    Update user
    Get all users
    Generate two-step auth for user
    Delete user
  PritunlApiClient::Key
    Download key
    Get key
    Download tar key
    Get tar key
    Download zip key
    Get zip key
    Download chromebook profile onc zip key
    Get chromebook profile onc zip key
    Get key temporary url
  PritunlApiClient::Server
    Create server
    Find server
    Get all servers
    Update server
    Attach organization
    Get all organizations on server
    Remove organization
    Start server
    Restart server
    Stop server
    Get server output
    Clear server output
  PritunlApiClient::Settings
    Get all settings
    Update settings

Finished in 1 minute 11.62 seconds (files took 0.17043 seconds to load)
38 examples, 0 failures
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

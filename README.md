# Pritunl API Client

API client for Pritunl written in Ruby.

[Pritunl](https://github.com/pritunl/pritunl) is a distributed enterprise
vpn server built using the OpenVPN protocol. See the official Pritunl API
documentation here: https://pritunl.com/api.html.  I am not affiliated with
Pritunl at all, but couldn't find a Ruby client for their API.  So I scratched
my own itch and created it myself.

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

### Ping

#### Server healthcheck.

```ruby
@pritunl.ping
```

### Status

#### Returns general information about the pritunl server.

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

### Log

#### Returns a list of server log entries sorted by time.

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

### Events

#### Get a list of events (will poll up to 30 seconds)

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eterry1388/pritunl_api_client.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

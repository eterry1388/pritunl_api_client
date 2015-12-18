# Pritunl API Client

API client for Pritunl written in Ruby.

[Pritunl](https://github.com/pritunl/pritunl) is a distributed enterprise
vpn server built using the OpenVPN protocol. See the official Pritunl API
documentation here: https://pritunl.com/api.html

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
    "email" => "user0@pritunl.com"
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
  "email" => "user0@pritunl.com"
}
```

### Create a new user in an organization. An array of users can be sent for bulk adding users.

```ruby
@pritunl.user.create(
  organization_id: org['id'],
  name: 'new_user',
  email: 'new_user@pritunl.com',
  disabled: true
)
```

### Rename or disabled an existing user in an organization. Disabling will also disconnect the user.

```ruby
@pritunl.user.update( user['id'],
  organization_id: org['id'],
  name: 'new_name',
  email: 'new_email@pritunl.com,
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

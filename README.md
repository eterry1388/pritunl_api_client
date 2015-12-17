# Pritunl API Client

API client for Pritunl written in Ruby.  See Pritunl API documentation here:  https://pritunl.com/api.html

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
@pritunl.organization.find( "55e99499b0e7300fef77e2b1" )

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
@pritunl.organization.update( 'fb48734e859242e2800f077216401736', name: 'new_name' )
```

### Delete an existing organization.

```ruby
@pritunl.organization.delete( '55e9f27bb0e730245677dc36' )
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eterry1388/pritunl_api_client.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Pritunl API Client

API client for Pritunl written in Ruby.  See Pritunl API documentation here:  https://pritunl.com/api.html

## Installation

```bash
gem install pritunl_api_client
```

## Usage

```ruby
@pritunl = PritunlApiClient::Client.new(
  ip:       '127.0.0.1',
  port:     9700,
  username: 'pritunl',
  password: 'pritunl',
  secure:   false
)
```

```ruby
@pritunl.organization.all
```

```json
[
  {
    user_count: 57,
    id: "5669e400c3439f0ec568877d",
    name: "org1"
  },
  {
    user_count: 21,
    id: "566804d92979db13996d0753",
    name: "org2"
  }
]
```

```ruby
@pritunl.organization.find( "5669e400c3439f0ec568877d" )
```

```json
{
  user_count: 57,
  id: "5669e400c3439f0ec568877d",
  name: "org1"
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eterry1388/pritunl_api_client.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Lontara Utilities

> Build Version: 3.0.0

This is a collection of utilities for your Ruby project provided by Lontara. These are:
- `LontaraUtilities` - a collection of utilities
- `HTTPClient` - Client for HTTP Connection
- `RMQ::Client` - Client for RabbitMQ Connection
- `RMQ::Server` - Server for RabbitMQ Connection
- `Git` - An interface to Git Branch and Release
- `BaseError` - Custom Error inherited from StandardError with some features

## Installation
Open your terminal and type:
```bash
gem install lontara_utilities
```

or add this line to your application's Gemfile:
```ruby
gem 'lontara_utilities'
```

If you wanna use the `git` method, you need to install `git` first, and then initialize it in your project directory.

For Rails project, you can use initializer to run RMQ Server. Just add `rmq.rb` file in `config/initializers` directory, and add this code:

> Note: Currently we only support `RPCConsumer` (from RPC Pattern) or `Subscriber` (from Pub/Sub Messaging Pattern) server.

```ruby
require 'lontara_utilities/rmq'

LontaraUtilities::RMQ.start(
  server: 'RPCConsumer',
  url: ENV.fetch('RABBITMQ_URL', 'amqp://guest:guest@rmqserver:5672'),
  queue: ENV.fetch('RABBITMQ_QUEUE_VOUCHER', 'lontara-dev.voucher')
)
```

## Usage
You can require this utilities by adding `require 'lontara_utilities'`, or you can require each utilities separately.

```ruby
require 'lontara_utilities/http_client'

LontaraUtilities::HTTPClient.get('http://example.com')
```

But, if `lontara_utilities` or it's alias: `lontara` is required, you can call these methods using  method format.

```ruby
require 'lontara_utilities' # or require 'lontara'

Lontara.http_client.get(url: 'http://example.com')
```

For usage of each utilities, please refer to the documentation: [Lontara Utilities](https://www.rubydoc.info/gems/lontara_utilities)

## Contributing
Bug reports and pull requests are welcome on GitHub at [Lontara Utilities](https://github.com/lontara-app/lontara_utilities).
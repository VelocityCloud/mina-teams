# Mina::Teams

This is a Teams plugin for [mina](https://github.com/mina-deploy/mina)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-teams'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install mina-teams
```

## Usage

in `deploy.rb`

```
require 'mina/teams'

task deploy: :environment do
  deploy do
    ...
    isolate do
      invoke 'teams:starting'
      # Deploy Commands
      invoke 'teams:finished'
    end
  end
  
  deploy do
    ...
    isolate do
      invoke 'teams:starting_restart'
      # Restart Commands
      invoke 'teams:finished_restart'
    end
  end
end
```

## Configuration

These are the settings you can set:
```
set :teams_url, 'https://your-company.webhook.office.com/webhookb2/xxx/IncomingWebhook/xxx/xxx'
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mina-deploy/mina-teams. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

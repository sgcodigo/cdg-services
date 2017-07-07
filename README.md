# CDG::Services

Codigo - Ruby on Rails Team's common services.

We adopted a microservice architecture in devising the approach of usage of this gem.

These services are functions that are expected to be commonly used among our projects.

This library serves to accumulate all this knowledge and speed up development without compromising quality and accuracy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cdg-services'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cdg-services

## Usage

Get the latest app version of any iOS app; `app_id` is the id of the app in the form of numerics, eg. `12345678`.
```ruby
CDG::Services.get_ios_version(app_id: app_id)
```


Get the latest app version of any Android app; `app_id` is the id of the app in the form of `com.package.name`.
```ruby
CDG::Services.get_android_version(app_id: app_id)
```


Send a message to any slack channel via a Slack webhook, eg. `https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX`. See how to set up a [Slack webhook](https://api.slack.com/incoming-webhooks).

Set the webhook in your application's environment variable with the name `SLACK_URL`. This gem access the webhook using `ENV['SLACK_URL']`.
```ruby
CDG::Services.get_android_version(app_id: app_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cdg-services. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CDG::Services project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cdg-services/blob/master/CODE_OF_CONDUCT.md).

# SimplestCaptcha
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "simplest_captcha"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install simplest_captcha
$ rails simplest_captcha:install:migrations
$ rails db:migrate SCOPE=simplest_captcha
```

You need to add this to your routes.rb
```
  mount SimplestCaptcha::Engine => "/captcha"
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

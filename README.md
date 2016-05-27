# R5

This gem is used for generating default project for Timepress company. However we hope it can be useful for other users as well.

## Installation locally

You can clone project and use bundler to install gem locally with "rake install".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r5'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r5

## Usage

Gem expects config file in home directory named .r5.yml, which should contain following:

```
mysql:
  user: 'mysql_user_name'
  password: 'mysql_password'

admin:
  login: 'default_admin_login'
  password: 'default_admin_password'
  email: 'default@admin.email'
  lastname: 'AdminLastName'

notifier:
  email: 'email@for_exception.notifier'

server:
  name: 'server_name_for_deploy_script'
  port: 'ssh_port_number'
  user: 'server_user_for_deploy'
```

Then you can create new application with r5 new name_of_app.
Custom installations types can be specified in 'installations' directory.

## TODO

1. provide deploy.sh for upload.rake task to actually work for others
2. Add testing for Rails presence before running installation

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/r5/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

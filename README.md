### Hexlet tests and linter status:
[![Actions Status](https://github.com/oddmdma/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/oddmdma/rails-project-63/actions)

# HexletCode

HexletCode is a Ruby gem for generating HTML forms. It provides a simple and flexible API for creating forms with various input types.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install hexlet_code
```

## Usage

### Basic Form

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

HexletCode.form_for user do |f|
  f.input :name
  f.input :job
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <input name="job" type="text" value="hexlet">
# </form>
```

### Form with Custom URL

```ruby
HexletCode.form_for user, url: '/users' do |f|
  f.input :name
  f.input :job
end

# <form action="/users" method="post">
#   <input name="name" type="text" value="rob">
#   <input name="job" type="text" value="hexlet">
# </form>
```

### Text Area Input

```ruby
HexletCode.form_for user do |f|
  f.input :job, as: :textarea
end

# <form action="#" method="post">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>
```

### Custom Attributes

```ruby
HexletCode.form_for user do |f|
  f.input :name, class: 'user-input'
  f.input :job, as: :textarea, rows: 50, cols: 50
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <textarea name="job" cols="50" rows="50">hexlet</textarea>
# </form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/oddmdma/rails-project-63.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
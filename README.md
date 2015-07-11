# SplitDmy
[![Build Status](https://travis-ci.org/CeeBeeUK/split_dmy.svg)](https://travis-ci.org/CeeBeeUK/split_dmy)
[![Code Climate](https://codeclimate.com/github/CeeBeeUK/split_dmy/badges/gpa.svg)](https://codeclimate.com/github/CeeBeeUK/split_dmy)
[![Test Coverage](https://codeclimate.com/github/CeeBeeUK/split_dmy/badges/coverage.svg)](https://codeclimate.com/github/CeeBeeUK/split_dmy/coverage)

[![security](https://hakiri.io/github/CeeBeeUK/split_dmy/master.svg)](https://hakiri.io/github/CeeBeeUK/split_dmy/master)

Allow splitting a date field into constituent day, month and year parts.

Splitting dates into constituent parts is recommended by the GOV.UK 
[service manual](https://www.gov.uk/service-manual/user-centred-design/resources/patterns/dates.html#memorable-dates) 
this gem is designed to allow a simple method of displaying the split date on a view, without having 
to manually de and re-compose the date in the controller.

This gem was inspired by [TimeSplitter](https://github.com/shekibobo/time_splitter) 
by [shekibobo](https://github.com/shekibobo), in turn based on 
[SplitDatetime](https://github.com/michihuber/split_datetime) 
by [Michi Huber](https://github.com/michihuber).
 
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'split_dmy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install split_dmy

## Usage

After bundling, assuming you have a person model with a date_of_birth attribute, add this to your model:
```ruby
class Person < ActiveRecord::Base
  extend SplitDmy::Accessors
  split_dmy_accessor :date_of_birth
end
```

In your view (if using slim):
```ruby
= form_for(@person) do |f|
  = f.text_field :date_of_birth_day
  = f.text_field :date_of_birth_month
  = f.text_field :date_of_birth_year
```

In your controller, add the new variables to the strong parameter list
```ruby
    params.require(:person).permit(:name, :date_of_birth_day, :date_of_birth_month, :date_of_birth_year)
```


## Contributing

1. Fork it ( https://github.com/ceebeeuk/split-date-dmy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

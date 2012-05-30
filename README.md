# Shine

Extract the most interesting sentences from an article.

## Installation

Add this line to your application's Gemfile:

    gem 'shine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shine

## Usage

    require 'shine'
    Shine.shine(string, :max_length => 500)


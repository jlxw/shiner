# Shiner

Extract the most interesting sentences from an article.

## Installation

Add this line to your application's Gemfile:

    gem 'shiner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shiner

## Usage

    require 'shiner'
    Shiner.shine(string, :max_length => 500)


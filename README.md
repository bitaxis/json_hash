# json_hash

This is a simple gem that provides method-like syntatic sugar on top of a JSON object via the JSONHash class.

## Installation

If you are using Bundler, simply add the following line to your Gemfile:

    gem "json_hash"

Otherwise, just type:

    gem install json_hash

## Usage

The canonical usage is to obtain some JSON text from a remote endpoint, and parse it.  For example:

```ruby
require "json_hash"
 => true
user = JSONHash.parse("http://example.org/users/1.json")
 => #<JSONHash:0x007fe0d320fd30 @json={"id"=>1, ...}
user.id
 => 1 
user.login
 => "john_smith" 
users = JSONHash.parse("http://cumulus.local/identity-manager/users.json")
 => [#<JSONHash:0x007fe0d322c368 @json={"id"=>1, ...}, ...]
users.count
 => 4 
users[1].login
 => "jane_smith" 
```

## Requirements

The json_hash gem relies on the following:

* The json gem
* The open-uri module
* The uri module

## Credits

This was inspired by a similar class I wrote in Python to parse Jenkin's RESTful API output, which made use of the
setattr() method.  I wanted to see if I can do something similar in Ruby.

Alas, since Ruby doesn't have something like setattr(), I've had to rely on method_missing() instead.

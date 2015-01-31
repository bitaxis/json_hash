# json_hash

This is a simple gem that provides method-like syntatic sugar on top of a JSON object via the JSONHash class.

## Installation

If you are using Bundler, simply add the following line to your Gemfile:

    gem "json_hash"

Otherwise, just type:

    gem install json_hash

## Usage

The canonical usage is to obtain some JSON text from a remote endpoint, and parse it.  For example:

    require "json_hash"
    user = JSONHash.parse("http://example.org/users/1.json")
    puts user.id # outputs 1

## Requirements

The json_hash gem relies on the following

* The json gem
* The open-uri module
* The uri module

## Credits

This was inspired by a similar class I wrote in Python to parse Jenkin's RESTful API output, which made use of the
setattr() method.  I wanted to see if I can do something similar in Ruby.

Alas, since Ruby doesn't have something like setattr(), I've had to rely on method_missing() instead.

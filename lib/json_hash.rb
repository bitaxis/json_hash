require "json"
require "open-uri"
require "uri"

##
# Provides syntactic sugar to a JSON structure.
# Given a Ruby hash h, instead of using h[key] to obtain its value, you can use the
# syntax of h.key, as if you are invoking a method.

class JSONHash

  VERSION = "0.0.3"

  ##
  # Initializer.  The json parameter is a Ruby hash.  Usually you would call JSON.parse to get such a hash.
  # @param json [Hash] A Ruby hash, usually obtained by calling JSON.parse or HTTP GET on a .json endpoint.

  def initialize(json)
    @json = json
    @json.each do |key,value|
      if value.class == Hash
        @json[key] = JSONHash.new(value)
      elsif value.class == Array
        values = value.collect { |v| v.class == Hash ? JSONHash.new(v) : v }
        @json[key] = values
      end
    end
  end

  ##
  # Whatever .method is invoked, it will convert that to a string and use it as the key to look it up in the hash.
  # @param method [String, Symbol] The name of method to invoke.
  # @param args The arguments supplied to the method.

  def method_missing(method, *args)
    @json[method.to_s] || @json[method.to_sym] || super
  end

  ##
  # Returns the underling JSON parsed hash structure.
  # @return [JSON] Underlying JSON object.

  def to_json
    @json
  end

  ##
  # Return a string representation of the JSON parsed hash structure.
  # @return [String] String representation of the underlying JSON object.

  def to_s
    @json.to_s
  end

  ##
  # Build an array of JSONHash objects if the argument is an array of Hash instances.  If the argument is an URI,
  # then parse the URI contents with JSON.parse, and then build it.  If the argument is a string, then parse it
  # using JSON.parse first, then try to parse it again.  Otherwise, assume it's a single Hash object and build
  # just a single JSONHash object.
  # @param from [Array, Hash, String, URI] Object to build from.
  # @return [Array, JSONHash] Either an array of JSONHash objects or a single JSONHash object.

  def self.parse(from)
    return JSONHash.new(from) if from.class == Hash
    return from.collect { |item| parse(item) } if from.class == Array
    return parse(JSON.parse(open(from) { |fp| fp.read })) if from.is_a? URI::Generic
    # Assume from is String from here on
    return parse(URI.parse(from)) if /^http[s]?:\/\/.+/ =~ from
    return parse(JSON.parse(from))
  end

end

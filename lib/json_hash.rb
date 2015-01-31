require "json"

##
# Provides syntactic sugar to a JSON structure.
# Given a Ruby hash h, instead of using h[key] to obtain its value, you can use the
# syntax of h.key, as if you are invoking a method.

class JSONHash

  ##
  # Initializer.  The json parameter is a Ruby hash.  Usually you would call JSON.parse to get such a hash.
  # @param json [Hash] A regular Ruby hash, usually obtained by calling JSON.parse or HTTP GET on a .json endpoint.

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
    @json[method.to_s] || super
  end

  ##
  # Returns the underling JSON parsed hash structure.

  def to_json
    @json
  end

  ##
  # Return a string representation of the JSON parsed hash structure.

  def to_s
    @json.to_s
  end

end

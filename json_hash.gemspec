Gem::Specification.new do |spec|

  spec.name        = "json_hash"
  spec.version     = "0.0.2.2"
  spec.date        = "2015-01-31"
  spec.summary     = "Adds syntactic sugar to JSON hash."
  spec.description = "A simple gem that adds method-like syntactic sugar to a JSON hash."
  spec.authors     = ["Nathan Brazil"]
  spec.email       = 'nb@bitaxis.com'
  spec.files       = [
    "lib/json_hash.rb",
    "LICENSE",
    "README.md"
    ]
  spec.homepage    = "https://github.com/bitaxis/json_hash.git"
  spec.license     = "MIT"

  spec.add_runtime_dependency "json", "~> 1.8", ">= 1.8.2"

end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-react-assets"
  gem.version       = "0.0.0"
  gem.authors       = ["Patrick O'Brien"]
  gem.email         = ["pobrien@goldstar.com"]
  gem.description   = "Package and push react assets locally"
  gem.summary       = "Package and push react assets locally"
  gem.homepage      = "https://github.com/goldstar/capistrano-react-assets"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'capistrano', '~> 3.1', '>= 3.1.0'
end

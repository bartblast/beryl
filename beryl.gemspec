lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beryl/version'

Gem::Specification.new do |spec|
  spec.name          = 'beryl'
  spec.version       = Beryl::VERSION
  spec.authors       = ['Bart Blast']
  spec.email         = ['bart@bartblast.com']

  spec.summary       = %q{Web framework}
  spec.description   = %q{Web framework}
  spec.homepage      = 'https://github.com/bartblast/beryl'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'bowser'
  spec.add_dependency 'capybara'
  spec.add_dependency 'opal'
  spec.add_dependency 'puma'
  spec.add_dependency 'rack'
end
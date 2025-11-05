# frozen_string_literal: true

require_relative 'lib/QNE/version'

Gem::Specification.new do |spec|
  spec.name = 'QNE'
  spec.version = QNE::VERSION
  spec.authors = ['Nujian Den Mark Meralpis']
  spec.email = ['denmarkmeralpis@gmail.com']
  spec.summary = 'Ruby client for QNE Optimum APIs'
  spec.description = 'Consumes QNE APIs'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.9'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'faraday', '>= 1.10'
  spec.add_dependency 'faraday-net_http_persistent', '>= 1.2'
  spec.add_dependency 'faraday-retry'
  spec.add_dependency 'net-http-persistent', '>= 4.0'
  spec.add_development_dependency 'webmock', '>= 3.4'
end

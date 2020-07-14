# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "cartafact_rb"
  s.version = "0.1.0"
  s.date = "2020-07-14"
  s.summary = "Ruby Client for the Cartafact Document Store"
  s.authors = ["Dan Thomas", "Trey Evans"]
  s.require_paths = ["lib"]
  s.license = "MIT"

  s.required_ruby_version = '>= 2.3.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.add_dependency "faraday", "~> 0.17.3"
end

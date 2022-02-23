require_relative "lib/simplest_captcha/version"

Gem::Specification.new do |spec|
  spec.name        = "simplest_captcha"
  spec.version     = SimplestCaptcha::VERSION
  spec.authors     = ["Ryan Kopf"]
  spec.email       = ["github@ryankopf.com"]
  spec.homepage    = "https://github.com/ryankopf/simplest_captcha"
  spec.summary     = "A very simple way to add simple image captcha."
  spec.description = "Adds an image captcha tag to weed out the simplest of spam."
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ryankopf/simplest_captcha"
  spec.metadata["changelog_uri"] = "https://github.com/ryankopf/simplest_captcha"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0"
end

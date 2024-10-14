# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "specinfra-backend-kubernetes"
  spec.version = "0.0.1"
  spec.authors = ["Charlie Sharpsteen"]
  spec.email = ["source@sharpsteen.net"]

  spec.summary = "Kubernetes backend for Specinfra"
  spec.license = "Unlicense"
  spec.required_ruby_version = ">= 2.7.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[spec/ .git .github Gemfile])
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "specinfra", "~> 2.90"
end

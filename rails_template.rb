gem_group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv"
  gem "irbtools", require: "irbtools/binding"
  gem "standard"
end

gem_group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman"
  gem "rails-erd"
  gem "reek"
  gem "solargraph-rails"
  gem "spring"
end

gem_group :test do
  gem "mocktail"
end

gem "rails_config"
gem "phlex-rails"

file ".reek.yml", <<~CODE
  ---
  detectors:
    IrresponsibleModule:
      enabled: false
    MissingSafeMethod:
      enabled: false
    UncommunicativeVariableName:
      accept:
        - "_"
        - e
  directories:
    "app/controllers":
      UnusedPrivateMethod:
        enabled: false
      InstanceVariableAssumption:
        enabled: false
    "app/helpers":
      UtilityFunction:
        enabled: false
    "app/mailers":
      InstanceVariableAssumption:
        enabled: false
    "app/models":
      InstanceVariableAssumption:
        enabled: false
  exclude_paths:
    - "db/"
CODE

file ".solargraph.yml", <<~CODE
  ---
  include:
    - "**/*.rb"
  exclude:
    - spec/**/*
    - vendor/**/*
    - ".bundle/**/*"
  require: []
  domains: []
  plugins:
    - solargraph-rails
  reporters:
    - require_not_found
  formatter: []
  require_paths: []
  max_files: 5000
  
CODE

after_bundle do
  generate("phlex:install")
  environment "config.enable_reloading = true", env: "test"
  run "bundle exec spring binstub --all"
  run "curl -o solargraph_rails.rb https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw"
  run "solargraph bundle"
  run "yard gems . "
  run "standardrb --fix-unsafely"

  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"

  puts <<~MESSAGE
    Make sure to add this snipet to your test/test_helper.rb file:
    ```
    include Mocktail::DSL

    def teardown
      super
      Mocktail.reset
    end
    ```
  MESSAGE
end

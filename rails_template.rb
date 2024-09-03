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
  gem "solargraph"
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

after_bundle do
  generate("phlex:install")
  environment "config.enable_reloading = true", env: "test"
  run "bundle exec spring binstub --all"
  run "curl -o solargraph_rails.rb https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw"
  run "solargraph bundle"

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

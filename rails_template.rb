gem_group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "capybara"
  gem "dotenv"
  gem "factory_bot_rails"
  gem "irbtools", require: 'irbtools/binding'
  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem "standard"
end

gem_group :development
  gem "better_errors"
  gem "rails-erd"
  gem "solargraph"
  gem "strong_migrations"
end

gem "rails_config"
gem "sidekiq"

after_bundle do
  generate('rspec:install')
  run "bundle exec spring binstub rspec"
  run "curl -o solargraph_rails.rb https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw"
  run "solargraph bundle"

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end

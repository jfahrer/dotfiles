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
  gem "rails-erd"
  gem "solargraph"
  gem "strong_migrations"
end

gem "rails_config"
gem "phlex-rails"

after_bundle do
  generate("phlex:install")
  run "curl -o solargraph_rails.rb https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw"
  run "solargraph bundle"

  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end

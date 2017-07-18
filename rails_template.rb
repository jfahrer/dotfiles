gem 'haml-rails'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem "capybara"
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "byebug"
  gem "shoulda-matchers"
end

gem_group :development, :test do
  gem 'irbtools', require: 'irbtools/binding'
  gem 'awesome_print'
end

run("bundle install")
generate("rspec:install")

run("bundle exec spring binstub rspec")
run("bundle exec spring binstub")

rake("db:create")

run "rm README.rdoc"
run "echo '# #{@app_name.titleize}' >> README.md"

git :init
git add: "."
git commit: "-a -m initial"

gem 'haml-rails'

gem_group :development, :test do
  gem "byebug"
  gem "capybara"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem 'spring-commands-rspec'
end

gem_group :development, :test do
  gem 'awesome_print'
  gem 'irbtools', require: 'irbtools/binding'
end

after_bundle do
  generate("rspec:install")

  run "rm README.rdoc"
  run "echo '# #{@app_name.titleize}' >> README.md"

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end

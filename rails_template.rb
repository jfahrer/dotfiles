gem 'haml-rails'

gem_group :development, :test do
  gem "byebug"
  gem "capybara"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem 'spring-commands-rspec'
end

gem_group :development, :test do
  gem 'awesome_print'
  gem 'irbtools', require: 'irbtools/binding'
end

run("bundle install")
generate("rspec:install")

run("bundle exec spring binstub rails rake rspec")

run "rm README.rdoc"
run "echo '# #{@app_name.titleize}' >> README.md"

run "rake haml:erb2haml"

file 'docker-compose.yml', <<-CODE
version: "3"

services:
  pg:
    image: postgres:9.6-alpine
    ports:
      - 5432:5432
    volumes:
      - pg-data:/var/lib/postgresql/data

volumes:
  pg-data:
CODE

file 'config/database.yml', <<-CODE
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>

  username: <%= ENV.fetch('PG_USERNAME', 'postgres') %>
  password: <%= ENV.fetch('PG_USERNAME', '') %>
  host: <%= ENV.fetch('PG_HOST', 'localhost') %>
  port: <%= ENV.fetch('PG_PORT', 5432) %>

development:
  <<: *default
  database: #{@app_name}_development

test:
  <<: *default
  database: #{@app_name}_test

production:
  <<: *default
  database: #{@app_name}_production
CODE

git :init
git add: '.'
git commit: "-a -m 'Initial commit'"


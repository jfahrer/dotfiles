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

run "rm README.rdoc"
run "echo '# #{@app_name.titleize}' >> README.md"


# The Dockerfile
file 'Dockerfile', <<-CODE
FROM jfahrer/#{@app_name}-gems:latest AS gems

FROM ruby:2.5.1
COPY --from=gems /usr/local/bundle /usr/local/bundle

ENV LANG C.UTF-8
ENV PATH ./bin:$PATH
ENV RAILS_LOG_TO_STDOUT true

RUN apt-get update -qq && apt-get install -y \
      build-essential \
      nodejs \
      postgresql-client

WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle install

WORKDIR /app
COPY . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
CODE


# Dockerfile to cache gems
file 'Dockerfile.gems', <<-CODE
FROM ruby:2.5.1

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
      build-essential \
      postgresql-client

WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle install

CMD echo Nothing to do here
CODE

# Compose file
file 'docker-compose.yml', <<-CODE
version: '3.4'

services:
  app:
    image: jfahrer/#{@app_name}:latest
    build:
      context: .
    volumes:
      - ./:/app:cached
    env_file:
      - config/env/application.env
    command: ["spring", "server"]

  web:
    image: jfahrer/#{@app_name}:latest
    ports:
      - 3000:3000
    volumes:
      - ./:/app:cached
    env_file:
      - config/env/application.env

  pg:
    image: postgres:9.6-alpine
    volumes:
      - pg-data:/var/lib/postgresql/data
    environment:
      - PG_USERNAME=postgres
      - PG_PASSWORD=postgres

volumes:
  pg-data:
CODE

# Compose file to build the gem caching image
file 'docker-compose.gems.yml', <<-CODE
version: '3.4'

services:
  gems:
    image: jfahrer/#{@app_name}-gems:latest
    build:
      context: .
      dockerfile: Dockerfile.gems
CODE


# File that holds the environment variables
file 'config/env/application.env', <<-CODE
PG_HOST=pg
PG_PORT=5432
PG_USERNAME=postgres
PG_PASSWORD=postgres
RAILS_ENV
CODE


# Docker compatible database.yml
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

# Make sure commands run with Compose
file '.run_with_compose', ''

run("docker-compose -f docker-compose.gems.yml build")
run("docker-compose -f docker-compose.yml build")
run("docker-compose run --rm app bundle install")
run("docker-compose run --rm app rails generate rspec:install")
run("docker-compose run --rm app bundle exec spring binstub rails rake rspec")
run("docker-compose run --rm app rake haml:erb2haml")

git :init
git add: '.'
git commit: "-a -m 'Initial commit'"


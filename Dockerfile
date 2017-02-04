# base on latest ruby base image
FROM ruby:2.2.1

# update and install dependencies
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpq-dev nodejs apt-utils

# setup app folders
RUN mkdir /app
WORKDIR /app

# copy over Gemfile and install bundle
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs 20 --retry 5

RUN curl --location --silent --show-error --fail \
      -o /usr/local/bin/await \
      https://github.com/betalo-sweden/await/releases/download/v0.4.0/await-linux-amd64 \
 && chmod +x /usr/local/bin/await

Add . /app

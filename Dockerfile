FROM ruby:2.3.3

RUN apt-get update && \
    apt-get install -y net-tools build-essential mysql-client

# Install gems
RUN mkdir /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile* /usr/src/app
RUN bundle install

# Upload source
COPY . /usr/src/app


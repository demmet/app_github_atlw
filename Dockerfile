FROM ruby:2.3.3

RUN apt-get update && \
    apt-get install -y net-tools build-essential mysql-client vim

RUN mkdir -p /app
WORKDIR /app/

COPY . /app/
RUN bundle install
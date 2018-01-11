FROM ruby:2.3.3

RUN apt-get update && \
    apt-get install -y net-tools build-essential mysql-client vim

RUN mkdir /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

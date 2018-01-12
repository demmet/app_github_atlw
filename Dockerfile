FROM ruby:2.3.3

RUN apt-get update && \
    apt-get install -y net-tools build-essential vim

# db configs
RUN apt-get -y install postgresql postgresql-client postgresql-contrib

EXPOSE 5432

# heroku install
# RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# code copy
RUN mkdir -p /app
WORKDIR /app/
COPY . /app/
RUN bundle install

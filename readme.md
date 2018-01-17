# App Github Atlw

This app was developed in Ruby and it access the GitHub API, retrieves data from repositories that utilizes the languages: Ruby, Java, C, PHP and Assembly, displays relevant details from the repositories and stores them in a PostgreSQL database.

It was developed as a test for Ateliware company.
Concepts, tools and knowledges utilized:
- Docker containers;
- Git version control;
- GitHub API;
- Ruby language with Sinatra Framework;
- PostgreSQL DBMS;
- Automated tests with RSpec and Capybara;
- Heroku deployment;

## App requirements

- Docker ([Install Docker](https://docs.docker.com/engine/installation/))

## How to run the app

Clone the repository and execute the commands that follows:

1. `docker-compose up -d`
1. `docker exec -it app_github bash`
1. `bundle install` (if necessary)
1. `rackup config.ru`

### How to run the tests

Same procedure as if running the app, but run the command:

4. `rspec` instead

require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'octokit'
require 'mysql'

load 'functions.rb'

set :bind, '0.0.0.0'
use_ssl = true

get '/welcome' do
  "<center><h4>Welcome!</h4></center>"
end

get '/' do
  redirect '/home'
end

get '/home' do
  erb :home
end

get '/repos/:repo' do


	repositorios = get_git_repos(params['repo'])
	repos_detalhes = []

	conn = connect

  conn.query("CREATE TABLE IF NOT EXISTS Repositorios(id INTEGER NOT NULL PRIMARY KEY, name VARCHAR(20), full_name VARCHAR(50), html_url VARCHAR(200), owner_login VARCHAR(25), owner_url VARCHAR(200), description VARCHAR(300), is_private BOOLEAN, language VARCHAR(20));")

	repositorios['items'].each do |repo| 
		r = get_details(repo)
		repos_detalhes << r
		insert(conn, r)
	end
	
  erb :repos, :locals => { :repositorios => repos_detalhes }

end

get '/detalhes/:id' do
	repo = find_repo(params['id'])

	if(repo)
		repo_hash = {
			id: repo[0],
			name: repo[1],
			full_name: repo[2],
			html_url: repo[3],
			owner_login: repo[4],
			owner_url: repo[5],
			description: repo[6].force_encoding("utf-8"),
			is_private: repo[7],
			language: repo[8]
		}

		erb :detalhes, :locals => { :repo => repo_hash }
	else
		redirect '/home'
	end
end

get '/connect' do
	begin

		con = Mysql::new('app_db', 'root', 'example')

		con.query("CREATE DATABASE rubydb")

		con.query("use rubydb")

		return con

	rescue Mysql::Error => e
		puts e.error
		erb :tests, :locals => { :msg => e }
	ensure
		con.close if con
	end

end





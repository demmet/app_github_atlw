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
  erb :home
end

get '/home' do
  erb :home
end

get '/repos/:repo' do


	repositorios = get_git_repos(params['repo'])

	conn = connect

  conn.query("CREATE TABLE IF NOT EXISTS Repositorios(id INTEGER NOT NULL PRIMARY KEY, name VARCHAR(20), full_name VARCHAR(50), html_url VARCHAR(200), owner_login VARCHAR(25), owner_url VARCHAR(200), description VARCHAR(300), is_private BOOLEAN, language VARCHAR(20));")

	repositorios['items'].each do |repo| 
		insert(conn, get_details(repo))
	end
	
  erb :repos, :locals => {:repositorios => repositorios}

end

get '/connect' do
	begin
		#con = DBConnect.connect('localhost', 'root', 'example')

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





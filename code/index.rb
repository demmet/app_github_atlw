require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'octokit'
require 'mysql'

load 'functions.rb'
load 'DBConnect.rb'

set :bind, '0.0.0.0'
use_ssl = true

begin
	con = DBConnect.Connect('localhost', 'root', 'example')
	puts con.get_server_info

	rs = con.query 'SELECT VERSION()'
	puts rs.fetch_row

rescue Mysql::Error => e
	puts e.error
ensure
	con.close if con
end

get '/welcome' do
  "<center><h4>Welcome!</h4></center>"

end

get '/testes' do
  erb :index
end

get '/repos/:repo' do
  erb :repos, :locals => {:repositorios => get_git_repos(params['repo'])}
end






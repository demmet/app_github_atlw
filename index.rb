
require 'sinatra'
require 'sinatra/reloader'
require 'octokit'
require 'pry-nav'

load 'functions.rb'
load 'Repositorios.rb'

set :bind, '0.0.0.0'
use_ssl = true

puts "Iniciando servidor..."
binding.pry
PG.connect(hostaddr: ENV['DATABASE_URL'])
binding.pry
github_repos = Repositorios.new.repos

conn = create_table

puts "Banco de dados configurado..."

insert_all(conn, github_repos)

puts "Repositórios carregados e armazenados no banco de dados... Enjoy!"

get '/welcome' do
  "<center><h4>Welcome!</h4></center>"
end

get '/' do
  redirect '/home'
end

get '/home' do
  erb :home
end

post '/repos' do

	repos_detalhes = []

	repositorios = github_repos[params['repo'].downcase]

	repositorios['items'].each do |repo|
		r = get_details(repo)
		repos_detalhes << r
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

get '/tests' do
	load 'tests.rb'
	Tests.new.teste
end




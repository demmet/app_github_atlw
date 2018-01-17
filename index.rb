
require 'sinatra/base'
require 'sinatra/reloader'
require 'octokit'
require 'pry-nav'

require_relative 'AppDb'
require_relative 'AppGithubApi'
require_relative 'Repository'

class AppGithubAtlw < Sinatra::Base

	set :root, File.dirname(__FILE__)
	set :bind, '0.0.0.0'

	configure :development do
    register Sinatra::Reloader
  end

	def initialize
		super
		puts "Iniciando servidor..."

		@db = AppDb.new

		puts "Banco de dados configurado..."

		api = AppGithubApi.new

		@repositories = 
		{
			ruby: [],
			c: [],
			java: [],
			php: [],
			assembly: []
		}

		repositories_by_language = api.get_language_repositories("ruby")

		repositories_by_language['items'].each do |repository|
			@repositories[:ruby] << Repository.new(repository)
		end

		repositories_by_language = api.get_language_repositories("c")

		repositories_by_language['items'].each do |repository|
			@repositories[:c] << Repository.new(repository)
		end

		repositories_by_language = api.get_language_repositories("java")

		repositories_by_language['items'].each do |repository|
			@repositories[:java] << Repository.new(repository)
		end

		repositories_by_language = api.get_language_repositories("php")

		repositories_by_language['items'].each do |repository|
			@repositories[:php] << Repository.new(repository)
		end

		repositories_by_language = api.get_language_repositories("assembly")

		repositories_by_language['items'].each do |repository|
			@repositories[:assembly] << Repository.new(repository)
		end
		
		@db.insert_all(@repositories[:ruby])
		@db.insert_all(@repositories[:c])
		@db.insert_all(@repositories[:java])
		@db.insert_all(@repositories[:php])
		@db.insert_all(@repositories[:assembly])

		puts "Repositórios carregados e armazenados no banco de dados... Enjoy!"

	end
	

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

		if(params[:repo].nil?)
			redirect '/home'
		end
		
	  erb :repos, :locals => { :repositories => @repositories[params['repo'].downcase.to_sym]}

	end

	get '/detalhes/:id' do
		
		repository = @db.find_repo(params['id'])
		
		if(repository)
			erb :detalhes, :locals => { :repository => repository }
		else
			redirect '/home'
		end
	end

end

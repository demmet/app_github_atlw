require 'pry-nav'


load 'functions.rb'
load 'Repositorios.rb'

class Tests

	def initialize
		
	end

	def teste
		repositorios = Repositorios.new
		binding.pry
		repositorios.repos['ruby']
		out = []
		repos_items = get_git_repos("ruby")['items']
		
	    repo = repos_items[0]
	    details = get_details(repo)
	    return details.class.to_s
		return get_git_repos("ruby")['items'].class.to_s
		insert(connect, get_details(get_git_repos("Ruby")['items'][0])).to_s
	end

end

teste = Tests.new
teste.teste


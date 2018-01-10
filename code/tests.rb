load 'index.rb'

class Tests

	def initialize
		
	end

	def teste
		insert(connect, get_details(get_git_repos("Ruby")['items'][0])).to_s
	end

end
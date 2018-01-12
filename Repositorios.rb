

class Repositorios

	attr_reader :repos

	def initialize
		@repos = {
			"ruby" => get_git_repos("ruby"),
			"java" => get_git_repos("java"),
			"c" =>  get_git_repos("c"),
			"php" =>  get_git_repos("php"),
			"assembly" =>  get_git_repos("assembly")
		}
	end

end
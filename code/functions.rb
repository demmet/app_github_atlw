require 'net/http'

def get_git_repos(language)

	client = Octokit::Client.new(:login => 'demmet', :password => 'Demeloso123')
	
  url = 'https://api.github.com/search/repositories?q=language:' + language + '&sort=stars&order=desc'
	uri = URI(url)

	request = Net::HTTP::Get.new(uri.path)
	request["Content-Type"] = "application/json"
	request["User-Agent"] = "Awesome-Octocat-App"

	response = Net::HTTP.get_response(uri)

	data = JSON.parse(response.body)

	return data
end


def get_repos(lang)
	repos = get_git_repos(lang)
	repos
end
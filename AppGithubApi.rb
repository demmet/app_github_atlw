require 'net/http'
require 'json'

class AppGithubApi

	def get_language_repositories(language)

	  url = "https://api.github.com/search/repositories?q=language:#{language}" \
	  	"&sort=stars&order=desc"
		uri = URI(url)

		request = Net::HTTP::Get.new(uri.path)
		request["Content-Type"] = "application/json"
		request["User-Agent"] = "Awesome-Octocat-App"

		response = Net::HTTP.get_response(uri)

		data = JSON.parse(response.body)
	end

end








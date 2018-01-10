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

def connect
	begin

		con = Mysql::new('app_db', 'root', 'example')

		con.query("CREATE DATABASE rubydb")

		con.query("use rubydb")

	rescue Mysql::Error => e
		puts e.error
	ensure
		con.close if con
	end

	return con = Mysql::new('app_db', 'root', 'example', 'rubydb')
end

def get_details(repositorio)
	details = {
		id: repositorio['id'],
		name: repositorio['name'],
		full_name: repositorio['full_name'],
		html_url: repositorio['html_url'],
		owner_login: repositorio['owner']['login'],
		owner_url: repositorio['owner']['html_url'],
		description: repositorio['description'],
		is_private: repositorio['private'],
		language: repositorio['language']
	}

end

def insert(conn, repo_details)

	begin

		rs = conn.query ("SELECT * FROM Repositorios WHERE id = #{repo_details[:id]}")
		if(rs.fetch_row == nil)
			return conn.query("INSERT INTO Repositorios(id, name, full_name, html_url, owner_login, owner_url, description, is_private, language) VALUES (#{repo_details[:id]}, '#{repo_details[:name]}', '#{repo_details[:full_name]}', '#{repo_details[:html_url]}', '#{repo_details[:owner_login]}', '#{repo_details[:owner_url]}', '#{repo_details[:description]}', #{repo_details[:is_private]}, '#{repo_details[:language]}')")
		else
			return conn.query("UPDATE Repositorios SET name = '#{repo_details[:name]}', full_name = '#{repo_details[:full_name]}', html_url = '#{repo_details[:html_url]}', owner_login = '#{repo_details[:owner_login]}', owner_url = '#{repo_details[:owner_url]}', description = '#{repo_details[:description]}', is_private = #{repo_details[:is_private]}, language = '#{repo_details[:language]}' WHERE id = #{repo_details[:id]}")
		end
	rescue Mysql::Error => e
	end

end

def find_repo(id)

	begin
		conn = connect

		rs = conn.query("SELECT * FROM Repositorios WHERE id = #{id}")
		
		return rs.fetch_row
	rescue Mysql::Error => e
	end

end





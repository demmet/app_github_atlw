require 'net/http'
require 'json'
require 'pg'


def get_git_repos(language)

  url = 'https://api.github.com/search/repositories?q=language:' + language + '&sort=stars&order=desc'
	uri = URI(url)

	request = Net::HTTP::Get.new(uri.path)
	request["Content-Type"] = "application/json"
	request["User-Agent"] = "Awesome-Octocat-App"

	response = Net::HTTP.get_response(uri)

	data = JSON.parse(response.body)

	return data
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

def connect
	
	begin

		con = nil

		if(ENV['DATABASE_URL'] == nil)

			con = PG.connect(host: 'app_db', dbname: 'rubydb', :user => 'postgres', 
        :password => 'example')
		else
			con = PG.connect(hostaddr: ENV['DATABASE_URL'])
		end

		return con
	rescue PG::Error => e
	end

end

def create_table
	conn = connect
	conn.query("CREATE TABLE IF NOT EXISTS Repositorios(id INTEGER NOT NULL PRIMARY KEY, name VARCHAR(20), full_name VARCHAR(50), html_url VARCHAR(200), owner_login VARCHAR(25), owner_url VARCHAR(200), description VARCHAR(300), is_private BOOLEAN, language VARCHAR(20))")
	conn
end

def insert(conn, repo_details)

	begin

		rs = conn.query ("SELECT * FROM Repositorios WHERE id = #{repo_details[:id]}")
		row = nil
		rs.each do |r|
			row = r
		end
		if(row == nil)
			conn.query("INSERT INTO Repositorios(id, name, full_name, html_url, owner_login, owner_url, description, is_private, language) VALUES (#{repo_details[:id]}, '#{repo_details[:name]}', '#{repo_details[:full_name]}', '#{repo_details[:html_url]}', '#{repo_details[:owner_login]}', '#{repo_details[:owner_url]}', '#{repo_details[:description]}', #{repo_details[:is_private]}, '#{repo_details[:language]}')")
			return true
		else
			conn.query("UPDATE Repositorios SET name = '#{repo_details[:name]}', full_name = '#{repo_details[:full_name]}', html_url = '#{repo_details[:html_url]}', owner_login = '#{repo_details[:owner_login]}', owner_url = '#{repo_details[:owner_url]}', description = '#{repo_details[:description]}', is_private = #{repo_details[:is_private]}, language = '#{repo_details[:language]}' WHERE id = #{repo_details[:id]}")
			return true
		end
	rescue PG::Error => e
		return nil
	end

end

def insert_all(conn, github_repos)
	github_repos.each do |repos| 
		repos[1]['items'].each do |repo|
			r = get_details(repo)
			insert(conn, r)
		end
	end
end

def find_repo(id)

	begin
		conn = connect

		rs = conn.query("SELECT * FROM Repositorios WHERE id = #{id}")
		
		rs.each do |row|
			return
		end
	rescue PG::Error => e
	end

end





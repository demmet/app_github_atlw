
#TODO: review insert_all/find_repo

require 'pg'

class AppDb

	def initialize
		@con = connect

		@con.query('CREATE TABLE IF NOT EXISTS
									Repository(
										id INTEGER NOT NULL PRIMARY KEY,
										name VARCHAR(40),
										full_name VARCHAR(100),
										html_url VARCHAR(200),
										owner_login VARCHAR(25),
										owner_url VARCHAR(200),
										description VARCHAR(500),
										is_private BOOLEAN,
										language VARCHAR(20))')

	end

	def connect
	
		begin

			@con = PG.connect (if(ENV['DATABASE_URL'].nil?)
				{ host: 'app_db', dbname: 'rubydb', :user => 'postgres',
	        :password => 'example' }
			else
				ENV['DATABASE_URL']
			end)

		rescue PG::Error => e
			puts e.error
		end

	end

	def insert(repository)

		begin

			rs = @con.query ("
				SELECT * FROM Repository WHERE id = #{repository.id}")

			if(rs.values.empty?)
				@con.query("
					INSERT INTO
						Repository(id, name, full_name, html_url, owner_login,
							owner_url, description, is_private, language)
					VALUES (
						#{repository.id}, '#{repository.name}',
						'#{repository.full_name}', '#{repository.html_url}',
						'#{repository.owner_login}', '#{repository.owner_url}',
						'#{repository.description}', #{repository.is_private},
						'#{repository.language}')")
				return true
			else
				@con.query("
					UPDATE Repository
					SET
						name = '#{repository.name}',
						full_name = '#{repository.full_name}',
						html_url = '#{repository.html_url}',
						owner_login = '#{repository.owner_login}',
						owner_url = '#{repository.owner_url}',
						description = '#{repository.description}',
						is_private = #{repository.is_private},
						language = '#{repository.language}'
					WHERE id = #{repository.id}")
				return true
			end
		rescue PG::Error => e
			puts e.error
		end

	end

	def insert_all(repositories)
		repositories.each do |repository| 
			insert(repository)
		end
	end

	def find_repo(id)
		begin

			query = "SELECT * FROM Repository"
			query += " WHERE id = #{id}" unless id.nil?
			
			rs = @con.query(query)
			
			return (
				if(rs.values.empty?)
					nil
				else
					rs.first
				end)
		
			
		rescue PG::Error => e
			puts e.error
		end

	end

	def get_random_repository
		begin
			rs = @con.query("SELECT * FROM Repository ORDER BY random() LIMIT 1;")
			rs.first
		rescue PG::Error => e
			puts e.error
		end
	end


end
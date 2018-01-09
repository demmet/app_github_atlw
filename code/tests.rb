require 'mysql'

load 'DBConnect'

begin
	con = DBConnect.Connect('localhost', 'root', 'example')
	puts con.get_server_info

	rs = con.query 'SELECT VERSION()'
	puts rs.fetch_row

rescue Mysql::Error => e
	puts e.error
ensure
	con.close if con
end

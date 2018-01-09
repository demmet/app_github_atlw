class DBConnect

	@@conn = nil

	def Connect (server, user, pass)
		@@conn = Mysql.new(server, user, pass)
	end

	def DBConnect.conn
		@@conn
	end

end


class Repository

	attr_reader :id, :name, :full_name, :html_url, :owner_url,
		:owner_login, :description, :is_private, :language

	def initialize(repository)
		@id = repository['id']
		@name = repository['name']
		@full_name = repository['full_name']
		@html_url = repository['html_url']
		@owner_login = repository['owner']['login']
		@owner_url = repository['owner']['html_url']
		@description = repository['description']
		@description = @description.gsub("\"", "\"\"").
			gsub("'", "''").force_encoding(Encoding::UTF_8) unless description.nil?
		@is_private = repository['private']
		@language = repository['language']
	end

end
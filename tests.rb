require 'pry-nav'


load 'functions.rb'
load 'Repositorios.rb'

class Tests

	def initialize
		
	end

	def teste
		puts ENV['DATABASE_URL']
	end

end

teste = Tests.new
teste.teste


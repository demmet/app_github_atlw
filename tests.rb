require 'pry-nav'
require 'sinatra'

load 'index.rb'
load 'functions.rb'
load 'Repositorios.rb'
#load 'spec_helper.rb'

def app() Sinatra::Application end

describe "Teste GitHub Ateliware - Testes de URL" do
  it "Deve acessar a página inicial e redirecionar para /home" do
    get '/'
    expect(last_response).to be_ok
  end
end

=begin
class TestSimpleNumber < Test::Unit::TestCase

	attribute :wtf

	class << self
    def startup
      puts "pqpman"
      @num = 2
    end

    def shutdown
      puts "exiting"
    end
  end

  def setup
  	
  end

  def teardown
    ## Nothing really
  end

  def test_simple
    assert_equal(4, @num+(2) )
  end

  def test_simple2
    assert_equal(4, @num*(2) )
  end

end

#TestSimpleNumber.startup



class Tests

	attr_reader :repositorios

	def initialize
		if(@repositorios == nil)
			@repositorios = Repositorios.new
		end
	end

	def teste
		binding.pry
	end

end

teste = Tests.new
puts teste.repositorios.repos.length
=end

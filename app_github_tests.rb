
require 'test/unit'
require 'rack/test'
require 'pry-nav'

load 'functions.rb'
load 'Repositorios.rb'

class AppTest < Test::Unit::TestCase
	include Rack::Test::Methods

  class << self
    def startup
      @@repositorios = Repositorios.new
    end

    def shutdown
      
    end
  end

	def app
		Sinatra::Application
	end

  def setup
    
  end

	#TESTS
	def test_get_repositorios_ruby
  	assert_equal("Hash", @@repositorios.repos['ruby'].class.to_s)
  end

  def test_get_repositorios_c
		assert_equal("Hash", @@repositorios.repos['c'].class.to_s)
  end

  def test_get_repositorios_java
  	assert_equal("Hash", @@repositorios.repos['java'].class.to_s)
  end

  def test_get_repositorios_php
		assert_equal("Hash", @@repositorios.repos['php'].class.to_s)
  end

  def test_get_repositorios_assembly
  	assert_equal("Hash", @@repositorios.repos['assembly'].class.to_s)
  end

  def test_get_repositorios_items
    assert_equal("Array", @@repositorios.repos['ruby']['items'].class.to_s)
  end

  def test_get_details_repositorio
    repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
  	assert_equal("Hash", details.class.to_s)
  end

  def test_get_details_repositorio_id
    repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:id])
  end

  def test_get_details_repositorio_name
    repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
  	assert_not_nil(details[:name])
  end

  def test_get_details_repositorio_full_name
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:full_name])
  end

  def test_get_details_repositorio_html_url
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:html_url])
  end

  def test_get_details_repositorio_owner_login
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:owner_login])
  end

  def test_get_details_repositorio_owner_url
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:owner_url])
  end

  def test_get_details_repositorio_description
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:description])
  end

  def test_get_details_repositorio_is_private
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:is_private])
  end

  def test_get_details_repositorio_language
  	repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
    assert_not_nil(details[:language])
  end

	def test_connect_db
    assert_not_nil @conn = connect
  end

  def test_insert_update_db
    repos_items = @@repositorios.repos['ruby']['items']
    repo = repos_items[0]
    details = get_details(repo)
  	assert(insert(connect, details))
  end

end


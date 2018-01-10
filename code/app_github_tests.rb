
require 'test/unit'
require 'rack/test'

load 'index.rb'

class AppTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	#TESTS
	def test_get_repositorios_ruby
  	assert_equal("Hash", get_git_repos("ruby").class.to_s)
  end

  def test_get_repositorios_c
		assert_equal("Hash", get_git_repos("c").class.to_s)
  end

  def test_get_repositorios_java
  	assert_equal("Hash", get_git_repos("java").class.to_s)
  end

  def test_get_repositorios_php
		assert_equal("Hash", get_git_repos("php").class.to_s)
  end

  def test_get_repositorios_assembly
  	assert_equal("Hash", get_git_repos("php").class.to_s)
  end

  def test_get_details_repositorio
  	assert_equal("Hash", (get_details(get_git_repos("ruby")['items'][0])).class.to_s)
  end

  def test_get_details_repositorio_id
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:id])
  end

  def test_get_details_repositorio_name
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:name])
  end

  def test_get_details_repositorio_full_name
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:full_name])
  end

  def test_get_details_repositorio_html_url
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:html_url])
  end

  def test_get_details_repositorio_owner_login
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:owner_login])
  end

  def test_get_details_repositorio_owner_url
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:owner_url])
  end

  def test_get_details_repositorio_description
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:description])
  end

  def test_get_details_repositorio_is_private
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:is_private])
  end

  def test_get_details_repositorio_language
  	assert_not_nil(get_details(get_git_repos("ruby")['items'][0])[:language])
  end

	def test_connect_db
    assert_not_nil @conn = connect
  end

  def test_insert_update_db
  	assert_not_nil(insert(connect, get_details(get_git_repos("Ruby")['items'][0])))
  end

end
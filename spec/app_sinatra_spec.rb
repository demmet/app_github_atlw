require 'capybara/rspec'

require File.expand_path '../spec_helper.rb', __FILE__

load 'index.rb'
require_relative '../AppDb'
require_relative '../Repository'
require_relative '../AppGithubApi'

Capybara.app = AppGithubAtlw

describe "Test Routes" do

	describe "App Github Atlw => " do
		context "get '/':" do
		  it "deve redirecionar para /home. (status 302)" do
		    get '/'
		    expect(last_response.status).to eq 302
		  end
		end
	end

	describe "App Github Atlw => " do
		context "get '/welcome':" do
		  it "deve retornar mensagem de boas-vindas. (status 200)" do
		    get '/welcome'
		    expect(last_response.status).to eq 200
		  end
		end
	end

	describe "App Github Atlw => " do
		context "get '/home':" do
		  it "deve retornar a página inicial da aplicação .(status 200)" do
		    get '/home'
		    expect(last_response.status).to eq 200
		  end
		end
	end

	describe "App Github Atlw => " do
		before(:each) do
			db = AppDb.new
			@id = db.get_random_repository['id']
		end

		context "get '/detalhes/:id' e id existe no banco:" do
		  it "deve retornar a página de detalhes do repositório com o id correspondente. (status 200)" do

		    get '/detalhes/' + @id
		    expect(last_response.status).to eq 200
		  end
		end
	end


	describe "App Github Atlw => " do
		context "get '/detalhes/:id' e id não existe no banco:" do
		  it "deve redirecionar para a página inicial. (status 302)" do

		    get '/detalhes/0'
		    expect(last_response.status).to eq 302
		  end
		end
	end

	describe "App Github Atlw => " do
		context "post '/repos' sem parâmetros " do
		  it "deve redirecionar para /home. (status 302)" do
		    post '/repos'
		    expect(last_response.status).to eq 302
		  end
		end
	end

	describe "App Github Atlw => " do
		context "post '/repos' com parâmetro 'repo' => 'ruby':" do
		  it "deve retornar a página que lista os repositórios de Ruby. (status 200)" do
		    post '/repos', { :repo => 'ruby' }
		    expect(last_response.status).to eq 200
		  end
		end
	end

end

feature "App Github Atlw => /home" do

	scenario "clicando em Ruby Repositories deve retornar a lista de repositórios da linguagem Ruby" do
		
		visit '/home'
		click_button 'ruby-btn'
		expect(page).to have_content "linguagem ruby"
	
	end

end


feature "App Github Atlw => /home" do

	scenario "acessar página de repositórios Ruby e clicar em Detalhes deve retornar a página de detalhes de um repositório" do
		
		visit '/home'
		click_button 'ruby-btn'
		click_button('Detalhes', match: :first)
		expect(page).to have_content "Detalhes do Repositório"
	
	end

end



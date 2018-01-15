require 'pry-nav'
require 'rspec'

load 'functions.rb'
load 'Repositorios.rb'




RSpec.configure do |config|
  config.before(:suite) do 
    @@repositorios = Repositorios.new
    puts "teste"
  end
end

describe 'TestFunctions' do

  describe 'Acessar a API do GitHub e solicitar repositórios' do
    context "dada uma linguagem dentre (Ruby, C, Java, PHP, Assembly)" do
      it "retorna um Hash com repositórios referentes à linguagem de entrada" do 
        expect(@@repositorios.repos['ruby']).to be_a_kind_of(Hash)
      end
    end
  end

  describe 'solicita a lista dos itens' do
    context "repositórios carregados" do
      it "retorna um array" do
        expect(@@repositorios.repos['ruby']['items']).to be_a_kind_of(Array)
      end
    end
  end

  describe 'solicita detalhes de um repositório' do
    context "array de repositorios recebido" do
      it "retorna um hash não vazio com os dados" do
        repos_items = @@repositorios.repos['ruby']['items']
        repo = repos_items[0]
        details = get_details(repo)
        expect(details).to be_a_kind_of(Hash)
        expect(details).not_to be_empty
      end
    end
  end

  describe 'solicita conexão ao banco' do
    context "conexão com o banco ainda não realizada" do
      it "retorna um objeto não nulo de conexão com o banco de dados" do
        conn = connect
        expect(conn).not_to be_nil
        expect(conn).to be_a_kind_of(PG::Connection)
      end
    end
  end

  describe 'inserir detalhes de repositório no banco' do
    context "repositório carregado e detalhes extraídos" do
      it "retorna true se o repositório for inserido ou atualizado no banco" do
        repos_items = @@repositorios.repos['ruby']['items']
        repo = repos_items[0]
        details = get_details(repo)
        expect(insert(connect, details)).to be true
      end
    end
  end

end





# App Github Atlw

O aplicativo acessa a API do GitHub, busca e exibe informações sobre repositórios que utilizam as linguagens Ruby, Java, C, PHP e Assembly e armazena as informações coletadas em um banco de dados MySQL.

Este aplicativo foi desenvolvido como uma avaliação para a empresa Ateliware. Conceitos/ferramentas utilizados:
- Docker containers;
- Controle de versões Git;
- GitHub API;
- Ruby e framework Sinatra;
- MySQL;
- Testes automatizados;
- Heroku deployment;

## Requisitos para executar o App

- Docker ([Install Docker](https://docs.docker.com/engine/installation/))

## Iniciar o App

Clonar o repositório, executar os comandos abaixo no terminal:

1. `docker-compose up -d`
1. `docker exec -it app_github bash`
1. `bundle install` (se necessário)
1. `ruby code/index.rb`

### Executar os testes automatizados

Mesmo procedimento da execução, utilizando o comando:

`ruby code/app_github_tests.rb`
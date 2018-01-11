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

## Como iniciar o App

Clonar o repositório, abrir o terminal e executar os comandos:

- `docker-compose up -d`
- `docker exec -it app_github bash`
- `ruby code/index.rb`

### Como executar os testes automatizados

Mesmo procedimento da execução substituindo o último comando por:

- `ruby code/app_github_tests.rb`
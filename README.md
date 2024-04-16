# Project Flutter UTFPR

## Descrição

Para primeira entrega o aplicativo deve permitir o usuário visualizar, favoritar e avaliar um filme.

## Instalação

1 - Clonar o repositório na sua máquina

```bash
  git clone https://github.com/RickyHideyukiTakakura/project-flutter-utfpr.git
```

2 - Entrar no diretório do projeto

```bash
  cd project-flutter-utfpr
```

3 - Instalar as dependências

```bash
  flutter pub get
```

4 - Rodar o projeto

```bash
  flutter run
```

## Requisitos

A primeira parte do projeto consiste em um projeto Flutter estruturado de acordo com algum padrão de projeto (e.g. MVC, MVVM, MVP, etc) e deve apresentar toda a interface do usuário (UI) com navegação entre as páginas. Nesta etapa devem realizar validações em formulários, mensagens de erro e o tratamento de variáveis para o recebimento de dados. Não é necessário salvar dados (isto será realizado na parte 2). Vocês podem fazer um repositório com dados estáticos ou em memória para trabalhar com os dados. Na parte 2, vocês devem apenas substituir essa implementação pelo banco de dados que irão utilizar.

## Integrantes

- Ricky Takakura
- Murilo Emanuel

## To-Do

- [x] Criar a page Home
  - [x] Criar a section Top Rated Movies
  - [x] Criar a section Favorite Movies
    - [x] Adicionar filmes a section (Ao clicar em favoritar um filme)
  - [x] Criar a section My Recent Reviews
    - [x] Adicionar reviews a section (Ao fazer um review de um filme)
- [x] Criar a page Details
  - [x] Mostrar detalhes do filme (title, description, genre, rating, etc)
- [x] Criar a page Review
  - [x] Criar um input para avaliar o filme
  - [x] Criar um input para escrever um review
  - [x] Criar um botão para favoritar o filme
  - [x] Criar um botão para salvar as alterações
  - [x] Alterar a page Details para exibir a review após ter publicado uma review
- [x] Criar a page My Reviews
- [x] Criar um Bottom Navigation
  - Home
  - My Reviews

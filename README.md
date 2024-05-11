# Project Flutter UTFPR

## Descrição

Para segunda entrega o aplicativo deve permitir o usuário fazer a autenticação/cadastro, salvar os filmes favoritados e as reviews em um banco de dados, o aplicativo deve trazer o catálogo de filme de api externa

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

Consiste na continuação do Projeto em Flutter (Parte 1), no qual os alunos devem realizar a integração do aplicativo com um sistema de banco de dados (online ou offline) e desenvolver ou integrar um sistema para a autenticação (login) dos usuários, protegendo o acesso às funcionalidades do aplicativo. Você pode escolher quais serviços deseja utilizar para o projeto. Importante: o uso de uma API não será considerado como banco de dados nesta etapa. Caso seu projeto inclua o uso de uma API ou de um backend próprio, você pode usar um banco de dados local (e.g. SharedPreferences ou Hive) para salvar dados locais (e.g. dados do usuário, tokens, preferências do app, etc).

## Integrantes

- Ricky Takakura
- Murilo Emanuel

## To-Do

- [x] Configurar o Firebase
- [x] Criar a page Auth
  - [x] Deve ser possível o usuário fazer login
  - [x] Deve ser possível o usuário se cadastrar
- [x] Trazer o catálogo de filme de uma API externa
- [x] Salvar os filmes favoritados em um Database
- [x] Salvar as reviews em um Database

Opcional

- [ ] Criar a page Top Rated Movies (a lista completa de filmes)
- [ ] Criar a page Profile
- [ ] Criar a page Search
- [ ] Ajustar Menu Drawer
- [ ] Refatorar o código

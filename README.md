# App de Tarefas

Este é um aplicativo de gerenciamento de tarefas desenvolvido em Flutter, que permite criar, editar, excluir e marcar tarefas como concluídas. As tarefas são persistidas localmente utilizando o SQLite.

## Tecnologias Utilizadas

- **Flutter**: 3.27.3
- **Dart**: 3.6.1
- **Gerenciamento de Estado**: MobX
- **Navegação e Injeção de Dependências**: Modular
- **Persistência de Dados**: Sqflite

## Funcionalidades

1. **Listagem de Tarefas**:
   - Exibe todas as tarefas cadastradas.
   - Permite marcar tarefas como concluídas.
   - Possibilita edição e exclusão de tarefas.

2. **Criação de Tarefas**:
   - Interface dedicada para adicionar novas tarefas ao banco de dados.

3. **Tarefas Finalizadas**:
   - Exibe apenas as tarefas que foram marcadas como concluídas.

## Instalação e Execução

1. Clone este repositório:
   ```sh
   git clone https://github.com/CharllysOmena/tasks-flutter.git
   cd /tasks-flutter/notechallenge/
   ```

2. Instale as dependências:
   ```sh
   flutter pub get
   ```

3. Execute o aplicativo:
   ```sh
   flutter run
   ```

## Estrutura do Projeto

```
/lib
  |- main.dart
  |- app_module.dart
  |- app_widget.dart
  |- modules/
     |- home/
        |- data/
           |- adapters/
              |- nota_adapter.dart
           |- entities/
              |- nota_entities.dart
           |- repositories/
              |- task_repository.dart
        |- interactors/
           |- states/
              |- cadastro_state.dart
              |- home_state.dart
           |- stores/
              |- cadastro_store.dart
              |- cadastro_store.g.dart
              |- finalizados_store.dart
              |- finalizados_store.g.dart
              |- home_store.dart
              |- home_store.g.dart
        |- ui/
           |- pages/
              |- cadastro_page.dart
              |- concluidas_page.dart
              |- home_page.dart
           |- widget/
              |- bottom_navigation_Person.dart
              |- custom_appbar.dart
              |- empty.dart
              |- error.dart
              |- loading.dart
              |- modal_cadastro.dart
              |- task_list.dart
              |- text_main.dart
        |- home_module.dart
```



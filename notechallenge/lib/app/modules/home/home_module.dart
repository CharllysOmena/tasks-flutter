import 'package:notechallenge/app/modules/home/data/repositories/notas_repository.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/finalizados_store.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/busca_store.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/cadastro_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/ui/pages/busca_page.dart';
import 'package:notechallenge/app/modules/home/ui/pages/cadastro_page.dart';
import 'package:notechallenge/app/modules/home/ui/pages/concluidas_page.dart';
import 'interactors/stores/home_store.dart';

import 'ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // REPOSITORIES
    Bind.lazySingleton((i) => TaskRepository()),

    // STORES
    Bind.lazySingleton((i) => FinalizadosStore()),
    Bind.lazySingleton((i) => BuscaStore()),
    Bind.lazySingleton(
      (i) => CadastroStore(
        taskRepository: i.get<TaskRepository>(),
      ),
    ),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ChildRoute("/cadastrar", child: (_, args) => CadastroPage()),
    ChildRoute("/busca", child: (_, args) => BuscaPage()),
    ChildRoute("/concluida", child: (_, args) => ConcluidasPage()),
  ];
}

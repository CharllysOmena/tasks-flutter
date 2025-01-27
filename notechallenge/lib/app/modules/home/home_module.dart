import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/ui/pages/busca_page.dart';
import 'package:notechallenge/app/modules/home/ui/pages/cadastro_page.dart';
import 'package:notechallenge/app/modules/home/ui/pages/concluidas_page.dart';
import 'interactors/stores/home_store.dart';

import 'ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
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

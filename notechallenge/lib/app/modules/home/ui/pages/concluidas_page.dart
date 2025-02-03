import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/finalizados_store.dart';

import '../../interactors/states/home_state.dart';
import '../widget/bottom_navigation_Person.dart';
import '../widget/custom_appbar.dart';
import '../widget/empty.dart';
import '../widget/error.dart';
import '../widget/loading.dart';
import '../widget/task_list.dart';
import '../widget/text_main.dart';

class ConcluidasPage extends StatefulWidget {
  final String title;
  const ConcluidasPage({super.key, this.title = 'ConcluidasPage'});
  @override
  ConcluidasPageState createState() => ConcluidasPageState();
}

class ConcluidasPageState extends State<ConcluidasPage> {
  late FinalizadosStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<FinalizadosStore>();
    store.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMain(nome: "Jhon"),
            Observer(
              builder: (context) => Text(
                "Você tem ${store.tasks?.length ?? 0} tarefas finalizadas.",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
            ),
            SizedBox(height: 20),
            Observer(
              builder: (_) {
                switch (store.state.runtimeType) {
                  case const (SuccessHomeState):
                    return TaskList(
                      store: store,
                      isCheck: true,
                    );
                  case const (LoadingHomeState):
                    return Loading();
                  case const (EmptyHomeState):
                    return EmptyWidget(mensagem: "notas finalizadas");
                  default:
                    return ErroWidget();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarPerson(index: 2),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/interactors/states/home_state.dart';
import 'package:notechallenge/app/modules/home/ui/widget/empty.dart';
import 'package:notechallenge/app/modules/home/ui/widget/loading.dart';
import 'package:notechallenge/app/modules/home/ui/widget/text_main.dart';
import '../../interactors/stores/home_store.dart';
import '../widget/bottom_navigation_Person.dart';
import '../widget/custom_appbar.dart';
import '../widget/error.dart';
import '../widget/task_list.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
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
                "Você tem ${store.tasks?.length ?? 0} tarefas adicionadas.",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
            ),
            SizedBox(height: 20),
            Observer(
              builder: (_) {
                switch (store.state.runtimeType) {
                  case const (SuccessHomeState):
                    return TaskList(store: store, isCheck: false);
                  case const (LoadingHomeState):
                    return Loading();
                  case const (EmptyHomeState):
                    return EmptyWidget(mensagem: "notas");
                  default:
                    return ErroWidget();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarPerson(index: 0),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/ui/widget/text_main.dart';
import '../../interactors/stores/home_store.dart';
import '../widget/bottom_navigation_Person.dart';
import '../widget/custom_appbar.dart';
import '../widget/note_list.dart';

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
            Text(
              "Você tem X tarefas para executar.",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
            SizedBox(height: 20),
            NoteList(tasks: []),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarPerson(index: 0),
    );
  }
}

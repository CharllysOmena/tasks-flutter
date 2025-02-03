import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/cadastro_store.dart';
import 'package:notechallenge/app/modules/home/ui/widget/bottom_navigation_Person.dart';

import '../widget/custom_appbar.dart';
import '../widget/modal_cadastro.dart';
import '../widget/text_main.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key? key, this.title = 'CadastroPage'}) : super(key: key);
  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  late CadastroStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<CadastroStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMain(nome: "Jhon"),
            Text(
              "Crie novas tarefas para executar.",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Center(
              child: Column(
                children: [
                  Image.asset("assets/image.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    child: Text(
                      "Add new tasks.",
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 16),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      store.dispose();
                      showEditAddTaskDialog(
                        context,
                        null,
                        true,
                        store.taskTitleController,
                        store.taskDescriptionController,
                        (task) => store.postTask(task),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 0, 110, 253),
                    ),
                    label: Text(
                      "Create task",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 110, 253),
                        fontSize: 16,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      backgroundColor: const Color.fromARGB(255, 235, 245, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBarPerson(index: 1),
    );
  }
}

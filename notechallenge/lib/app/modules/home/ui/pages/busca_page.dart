import 'package:flutter/material.dart';
import 'package:notechallenge/app/modules/home/ui/widget/bottom_navigation_Person.dart';

import '../widget/custom_appbar.dart';
import '../widget/text_main.dart';

class BuscaPage extends StatefulWidget {
  final String title;
  const BuscaPage({Key? key, this.title = 'BuscaPage'}) : super(key: key);
  @override
  BuscaPageState createState() => BuscaPageState();
}

class BuscaPageState extends State<BuscaPage> {
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
              "Crie novas tarefas para executar.",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarPerson(index: 2),
    );
  }
}

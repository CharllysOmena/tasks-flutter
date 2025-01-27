import 'package:flutter/material.dart';

import '../widget/bottom_navigation_Person.dart';
import '../widget/custom_appbar.dart';
import '../widget/text_main.dart';

class ConcluidasPage extends StatefulWidget {
  final String title;
  const ConcluidasPage({Key? key, this.title = 'ConcluidasPage'})
      : super(key: key);
  @override
  ConcluidasPageState createState() => ConcluidasPageState();
}

class ConcluidasPageState extends State<ConcluidasPage> {
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
      bottomNavigationBar: BottomBarPerson(index: 3),
    );
  }
}

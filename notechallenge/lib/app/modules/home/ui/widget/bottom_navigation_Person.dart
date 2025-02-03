import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomBarPerson extends StatelessWidget {
  final int index;

  const BottomBarPerson({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> _routes = [
      "/",
      "/cadastrar",
      "/concluida",
    ];

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: index,
      onTap: (index) {
        Modular.to.navigate(_routes[index]);
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Tarefas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Nova tarefa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_outlined),
          label: 'Concluídas',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}

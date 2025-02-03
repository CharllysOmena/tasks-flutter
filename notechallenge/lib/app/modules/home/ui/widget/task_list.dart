import 'package:flutter/material.dart';
import 'modal_cadastro.dart';

class TaskList extends StatelessWidget {
  final store;
  final bool isCheck;
  const TaskList({
    super.key,
    required this.store,
    required this.isCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: store.tasks!.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Checkbox(
                        value: store.tasks![index].status,
                        onChanged: (value) {
                          if (!isCheck) {
                            store.alterarStatus(store.tasks![index].id!);
                          }
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 13,
                    child: ListTile(
                      title: Text(
                        store.tasks![index].titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        store.tasks![index].descricao,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  (isCheck)
                      ? Container()
                      : Flexible(
                          flex: 2,
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 20,
                            ),
                            onSelected: (value) {
                              if (value == 'editar') {
                                store.taskTitleController.text =
                                    store.tasks![index].titulo;
                                store.taskDescriptionController.text =
                                    store.tasks![index].descricao;
                                showEditAddTaskDialog(
                                  context,
                                  store.tasks![index],
                                  false,
                                  store.taskTitleController,
                                  store.taskDescriptionController,
                                  (task) => store.putTask(task),
                                );
                              } else if (value == 'excluir') {
                                store.deleteTask(store.tasks![index].id!);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'editar',
                                child: Text('Editar'),
                              ),
                              const PopupMenuItem(
                                value: 'excluir',
                                child: Text('Excluir'),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

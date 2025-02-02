import 'package:flutter/material.dart';
import 'package:notechallenge/app/modules/home/interactors/stores/finalizados_store.dart';

class TaskListFinalizados extends StatelessWidget {
  final FinalizadosStore store;
  const TaskListFinalizados({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: store.tasks!.length,
        itemBuilder: (_, index) {
          if (store.tasks![index].status == true) {
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
                          onChanged: (value) {},
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
                    Flexible(
                      flex: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

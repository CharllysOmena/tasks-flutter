import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/adapters/nota_adapter.dart';
import '../../data/entities/nota_entities.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController taskTitleController;
  final TextEditingController taskDescriptionController;
  final Function(Task) onSave;

  const AddTaskDialog({
    Key? key,
    required this.taskTitleController,
    required this.taskDescriptionController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Task",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 110, 253),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: taskTitleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'TAREFA',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: taskDescriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DESCRIÇÃO',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 245, 255),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.5,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    onSave(
                      TaskAdapter.fromMap({
                        "titulo": taskTitleController.text,
                        "descricao": taskDescriptionController.text,
                        "status": false,
                      }),
                    );
                    Modular.to.pop();
                    Modular.to.navigate("/");
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 110, 253),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showAddTaskDialog(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController,
    Function(Task) onSave) {
  showDialog(
    context: context,
    builder: (_) => AddTaskDialog(
      taskTitleController: titleController,
      taskDescriptionController: descriptionController,
      onSave: onSave,
    ),
  );
}

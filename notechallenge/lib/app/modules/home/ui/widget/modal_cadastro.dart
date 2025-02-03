import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/adapters/nota_adapter.dart';
import '../../data/entities/nota_entities.dart';

class AddEditTaskDialog extends StatelessWidget {
  final Task? task;
  final bool isAdd;
  final TextEditingController taskTitleController;
  final TextEditingController taskDescriptionController;
  final Function(Task) onSave;

  const AddEditTaskDialog({
    super.key,
    required this.isAdd,
    required this.taskTitleController,
    required this.taskDescriptionController,
    required this.onSave,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isAdd ? "Adicionar Tarefa" : "Editar Tarefa",
            style: const TextStyle(
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
                    final taskData = {
                      "titulo": taskTitleController.text,
                      "descricao": taskDescriptionController.text,
                    };

                    if (isAdd) {
                      onSave(
                          TaskAdapter.fromMap({...taskData, "status": false}));
                      Modular.to.pop();
                      Modular.to.navigate("/");
                    } else {
                      if (task != null &&
                          (task!.titulo != taskData["titulo"] ||
                              task!.descricao != taskData["descricao"])) {
                        onSave(TaskAdapter.fromMap({
                          ...taskData,
                          "id": task!.id,
                          "status": task!.status,
                        }));
                      }
                      Modular.to.pop();
                    }
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

void showEditAddTaskDialog(
  BuildContext context,
  Task? task,
  bool isAdd,
  TextEditingController titleController,
  TextEditingController descriptionController,
  Function(Task) onSave,
) {
  showDialog(
    context: context,
    builder: (_) => AddEditTaskDialog(
      task: task,
      isAdd: isAdd,
      taskTitleController: titleController,
      taskDescriptionController: descriptionController,
      onSave: onSave,
    ),
  );
}

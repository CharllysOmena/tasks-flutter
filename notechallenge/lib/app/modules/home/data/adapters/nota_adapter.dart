import '../entities/nota_entities.dart';

class TaskAdapter {
  TaskAdapter._();

  static Map<String, dynamic> toMap(Task task) {
    final map = {
      'titulo': task.titulo,
      'descricao': task.descricao,
      'status': task.status ? 1 : 0,
    };

    if (task.id != null) {
      map['id'] = task.id!;
    }

    return map;
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      status: map['status'] == 1,
    );
  }
}

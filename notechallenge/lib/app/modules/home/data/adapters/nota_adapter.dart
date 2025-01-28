import '../entities/nota_entities.dart';

class TaskAdapter {
  TaskAdapter._();

  static Task fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        descricao: json["descricao"],
        titulo: json["titulo"],
        status: json["status"] == 1,
      );

  static Map<String, dynamic> toMap(Task task) {
    return {
      'id': task.id,
      'titulo': task.titulo,
      'descricao': task.descricao,
      'status': task.status ? 1 : 0,
    };
  }
}

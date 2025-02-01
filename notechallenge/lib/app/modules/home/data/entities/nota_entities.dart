class Task {
  int? id;
  String titulo;
  String descricao;
  bool status;

  Task({
    this.id,
    required this.descricao,
    required this.titulo,
    required this.status,
  });
}

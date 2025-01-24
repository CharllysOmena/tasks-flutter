import 'package:notechallenge/app/modules/home/data/entities/nota_entities.dart';

class NotaAdapter {
  NotaAdapter._();

  static Nota fromMap(Map<String, dynamic> json) => Nota(
        id: json["id"],
        descricao: json["descricao"],
        titulo: json["titulo"],
        status: json["status"] == 1,
      );

  static Map<String, dynamic> toMap(Nota nota) {
    return {
      'id': nota.id,
      'titulo': nota.titulo,
      'descricao': nota.descricao,
      'status': nota.status ? 1 : 0,
    };
  }
}

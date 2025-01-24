import 'package:notechallenge/app/modules/home/data/adapters/nota_adapter.dart';
import 'package:notechallenge/app/modules/home/data/entities/nota_entities.dart';
import 'package:notechallenge/app/modules/home/interactors/states/cadastro_state.dart';
import 'package:notechallenge/app/modules/home/interactors/states/home_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract interface class INotasRepository {
  Future<HomeState> getNotas();
  Future<CadastroState> postNota(Nota nota);
  Future<CadastroState> putNota(Nota nota);
  Future<HomeState> deleteNota(String id);
  Future<CadastroState> alterarStatus(String id);
}

class NotasRepository implements INotasRepository {
  static const String tableNotas = 'notas';
  late Database _db;

  Future<void> initDatabase() async {
    final path = join(await getDatabasesPath(), 'notas.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableNotas (
            id TEXT PRIMARY KEY,
            titulo TEXT,
            descricao TEXT,
            status INTEGER
          )
        ''');
      },
    );
  }

  @override
  Future<HomeState> getNotas() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(tableNotas);
      List<Nota> notas = maps.map((map) => NotaAdapter.fromMap(map)).toList();
      return (notas.isEmpty)
          ? EmptyHomeState()
          : SuccessHomeState(notas: notas);
    } catch (e) {
      print(e);
      return ErrorExceptionHomeState(error: "Erro ao receber as notas!");
    }
  }

  @override
  Future<CadastroState> postNota(Nota nota) async {
    try {
      await _db.insert(
        tableNotas,
        NotaAdapter.toMap(nota),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return SuccessCadastroState();
    } catch (e) {
      print(e);
      return ErrorExceptionCadastroState(error: "Erro ao salvar os dados!");
    }
  }

  @override
  Future<CadastroState> putNota(Nota nota) async {
    try {
      await _db.update(
        tableNotas,
        NotaAdapter.toMap(nota),
        where: 'id = ?',
        whereArgs: [nota.id],
      );
      return SuccessCadastroState();
    } catch (e) {
      print(e);
      return ErrorExceptionCadastroState(error: "Erro ao atualizar os dados!");
    }
  }

  @override
  Future<HomeState> deleteNota(String id) async {
    try {
      await _db.delete(
        tableNotas,
        where: 'id = ?',
        whereArgs: [id],
      );
      return SuccessHomeState();
    } catch (e) {
      print(e);
      return ErrorExceptionHomeState(error: "Erro ao deletar as nota!");
    }
  }

  @override
  Future<CadastroState> alterarStatus(String id) async {
    try {
      final List<Map<String, dynamic>> result = await _db.query(
        tableNotas,
        columns: ['status'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final currentStatus = result.first['status'] == 1;
        final newStatus = !currentStatus;

        await _db.update(
          tableNotas,
          {'status': newStatus ? 1 : 0},
          where: 'id = ?',
          whereArgs: [id],
        );
        return SuccessCadastroState();
      } else {
        return ErrorExceptionCadastroState(error: "Erro ao alterar status");
      }
    } catch (e) {
      return ErrorExceptionCadastroState(error: "Erro ao alterar status");
    }
  }
}

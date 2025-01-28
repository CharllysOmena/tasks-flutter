import 'package:notechallenge/app/modules/home/interactors/states/cadastro_state.dart';
import 'package:notechallenge/app/modules/home/interactors/states/home_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../adapters/nota_adapter.dart';
import '../entities/nota_entities.dart';

abstract interface class ITaskRepository {
  Future<HomeState> getTasks();
  Future<CadastroState> postTask(Task task);
  Future<CadastroState> putTask(Task task);
  Future<HomeState> deleteTask(String id);
  Future<CadastroState> alterarStatus(String id);
}

class TaskRepository implements ITaskRepository {
  static const String tableTasks = 'tasks';
  late Database _db;

  Future<void> initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableTasks (
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
  Future<HomeState> getTasks() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(tableTasks);
      List<Task> tasks = maps.map((map) => TaskAdapter.fromMap(map)).toList();
      return (tasks.isEmpty)
          ? EmptyHomeState()
          : SuccessHomeState(tasks: tasks);
    } catch (e) {
      print(e);
      return ErrorExceptionHomeState(error: "Erro ao receber as tasks!");
    }
  }

  @override
  Future<CadastroState> postTask(Task task) async {
    try {
      await _db.insert(
        tableTasks,
        TaskAdapter.toMap(task),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return SuccessCadastroState();
    } catch (e) {
      print(e);
      return ErrorExceptionCadastroState(error: "Erro ao salvar os dados!");
    }
  }

  @override
  Future<CadastroState> putTask(Task task) async {
    try {
      await _db.update(
        tableTasks,
        TaskAdapter.toMap(task),
        where: 'id = ?',
        whereArgs: [task.id],
      );
      return SuccessCadastroState();
    } catch (e) {
      print(e);
      return ErrorExceptionCadastroState(error: "Erro ao atualizar os dados!");
    }
  }

  @override
  Future<HomeState> deleteTask(String id) async {
    try {
      await _db.delete(
        tableTasks,
        where: 'id = ?',
        whereArgs: [id],
      );
      return SuccessHomeState();
    } catch (e) {
      print(e);
      return ErrorExceptionHomeState(error: "Erro ao deletar as task!");
    }
  }

  @override
  Future<CadastroState> alterarStatus(String id) async {
    try {
      final List<Map<String, dynamic>> result = await _db.query(
        tableTasks,
        columns: ['status'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final currentStatus = result.first['status'] == 1;
        final newStatus = !currentStatus;

        await _db.update(
          tableTasks,
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

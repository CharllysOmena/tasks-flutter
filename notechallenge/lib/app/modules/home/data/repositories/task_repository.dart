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
  Future<HomeState> deleteTask(int id);
  Future<CadastroState> alterarStatus(int id);
}

class TaskRepository implements ITaskRepository {
  static const String tableTasks = 'tasks';
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableTasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(tableTasks);
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
      final db = await database;
      int id = await db.insert(
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
    if (task.id == null) {
      return ErrorExceptionCadastroState(
          error: "ID inválido para atualização!");
    }
    try {
      final db = await database;
      await db.update(
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
  Future<HomeState> deleteTask(int id) async {
    try {
      final db = await database;
      await db.delete(
        tableTasks,
        where: 'id = ?',
        whereArgs: [id],
      );
      return SuccessHomeState();
    } catch (e) {
      print(e);
      return ErrorExceptionHomeState(error: "Erro ao deletar a task!");
    }
  }

  @override
  Future<CadastroState> alterarStatus(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        tableTasks,
        columns: ['status'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final currentStatus = result.first['status'] == 1;
        final newStatus = !currentStatus;

        await db.update(
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
      print(e);
      return ErrorExceptionCadastroState(error: "Erro ao alterar status");
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:notechallenge/app/modules/home/data/entities/nota_entities.dart';
import 'package:notechallenge/app/modules/home/data/repositories/notas_repository.dart';
import 'package:notechallenge/app/modules/home/interactors/states/cadastro_state.dart';
import 'package:notechallenge/app/modules/home/interactors/states/home_state.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}

@GenerateMocks([Database])
void main() {
  late MockDatabase mockDatabase;
  late NotasRepository notasRepository;

  setUp(() async {
    mockDatabase = MockDatabase();
    notasRepository = NotasRepository();
    await notasRepository.initDatabase();
  });

  group('NotasRepository Tests', () {
    test('getNotas retorna lista de notas com sucesso', () async {
      when(mockDatabase.query(any)).thenAnswer((_) async => [
            {
              'id': '1',
              'titulo': 'Nota 1',
              'descricao': 'Descrição 1',
              'status': 1,
            },
            {
              'id': '2',
              'titulo': 'Nota 2',
              'descricao': 'Descrição 2',
              'status': 0,
            },
          ]);

      final state = await notasRepository.getNotas();

      expect(state, isA<SuccessHomeState>());
      expect((state as SuccessHomeState).notas!.length, 2);
    });

    test('postNota salva uma nota com sucesso', () async {
      final nota = Nota(
        id: '1',
        titulo: 'Nota Teste',
        descricao: 'Descrição Teste',
        status: true,
      );

      when(mockDatabase.insert(any, any,
              conflictAlgorithm: anyNamed('conflictAlgorithm')))
          .thenAnswer((_) async => 1);

      final state = await notasRepository.postNota(nota);

      expect(state, isA<SuccessCadastroState>());
      verify(mockDatabase.insert(any, any,
              conflictAlgorithm: ConflictAlgorithm.replace))
          .called(1);
    });

    test('putNota atualiza uma nota com sucesso', () async {
      final nota = Nota(
        id: '1',
        titulo: 'Nota Atualizada',
        descricao: 'Descrição Atualizada',
        status: false,
      );

      when(mockDatabase.update(any, any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final state = await notasRepository.putNota(nota);

      expect(state, isA<SuccessCadastroState>());
      verify(mockDatabase.update(any, any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .called(1);
    });

    test('deleteNota remove uma nota com sucesso', () async {
      when(mockDatabase.delete(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final state = await notasRepository.deleteNota('1');

      expect(state, isA<SuccessHomeState>());
      verify(mockDatabase.delete(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .called(1);
    });

    test('alterarStatus alterna status da nota com sucesso', () async {
      when(mockDatabase.query(any,
              columns: anyNamed('columns'),
              where: anyNamed('where'),
              whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [
                {'status': 1}
              ]);

      when(mockDatabase.update(any, any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final state = await notasRepository.alterarStatus('1');

      expect(state, isA<SuccessCadastroState>());
      verify(mockDatabase.update(any, any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .called(1);
    });

    test('alterarStatus retorna erro quando ID não encontrado', () async {
      when(mockDatabase.query(any,
              columns: anyNamed('columns'),
              where: anyNamed('where'),
              whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => []);

      final state = await notasRepository.alterarStatus('999');

      expect(state, isA<ErrorExceptionCadastroState>());
      verifyNever(mockDatabase.update(any, any,
          where: anyNamed('where'), whereArgs: anyNamed('whereArgs')));
    });
  });
}

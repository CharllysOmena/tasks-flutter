// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalizados_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FinalizadosStore on _FinalizadosStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_FinalizadosStoreBase.state', context: context);

  @override
  HomeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HomeState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_FinalizadosStoreBaseActionController =
      ActionController(name: '_FinalizadosStoreBase', context: context);

  @override
  dynamic emit(HomeState newState) {
    final _$actionInfo = _$_FinalizadosStoreBaseActionController.startAction(
        name: '_FinalizadosStoreBase.emit');
    try {
      return super.emit(newState);
    } finally {
      _$_FinalizadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}

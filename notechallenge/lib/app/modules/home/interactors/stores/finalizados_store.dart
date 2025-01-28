import 'package:mobx/mobx.dart';

part 'finalizados_store.g.dart';

class FinalizadosStore = _FinalizadosStoreBase with _$FinalizadosStore;
abstract class _FinalizadosStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}
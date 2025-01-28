import 'package:mobx/mobx.dart';

part 'busca_store.g.dart';

class BuscaStore = _BuscaStoreBase with _$BuscaStore;
abstract class _BuscaStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}
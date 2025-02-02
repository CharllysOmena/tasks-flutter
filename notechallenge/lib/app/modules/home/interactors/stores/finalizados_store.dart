import 'package:mobx/mobx.dart';

import '../../data/entities/nota_entities.dart';
import '../../data/repositories/task_repository.dart';
import '../states/home_state.dart';

part 'finalizados_store.g.dart';

class FinalizadosStore = _FinalizadosStoreBase with _$FinalizadosStore;

abstract class _FinalizadosStoreBase with Store {
  final ITaskRepository taskRepository;

  @observable
  HomeState state = StartHomeState();

  @action
  emit(HomeState newState) => state = newState;

  List<Task>? tasks;

  _FinalizadosStoreBase({required this.taskRepository});

  getTasks() async {
    emit(LoadingHomeState());
    var response = await taskRepository.getTasks();
    (response is SuccessHomeState)
        ? tasks = response.tasks?.where((task) => task.status == true).toList()
        : tasks = [];
    emit(response);
  }
}

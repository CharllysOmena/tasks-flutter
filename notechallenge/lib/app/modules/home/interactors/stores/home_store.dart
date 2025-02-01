import 'package:mobx/mobx.dart';
import 'package:notechallenge/app/modules/home/data/entities/nota_entities.dart';
import 'package:notechallenge/app/modules/home/interactors/states/home_state.dart';

import '../../data/repositories/task_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ITaskRepository taskRepository;

  @observable
  HomeState state = StartHomeState();

  @action
  emit(HomeState newState) => state = newState;

  List<Task>? tasks;

  HomeStoreBase({required this.taskRepository});

  getTasks() async {
    emit(LoadingHomeState());
    var response = await taskRepository.getTasks();
    (response is SuccessHomeState) ? tasks = response.tasks : tasks = [];
    emit(response);
  }

  alterarStatus(int id) async {
    await taskRepository.alterarStatus(id);
    getTasks();
  }
}

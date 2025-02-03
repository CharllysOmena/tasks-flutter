import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:notechallenge/app/modules/home/interactors/states/cadastro_state.dart';

import '../../data/entities/nota_entities.dart';
import '../../data/repositories/task_repository.dart';

part 'cadastro_store.g.dart';

class CadastroStore = _CadastroStoreBase with _$CadastroStore;

abstract class _CadastroStoreBase with Store {
  final ITaskRepository taskRepository;

  _CadastroStoreBase({required this.taskRepository});

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  CadastroState state = StartCadastroState();

  emit(CadastroState newState) => state = newState;

  postTask(Task task) async {
    emit(LoadingCadastroState());
    CadastroState response = await taskRepository.postTask(task);
    emit(response);
  }

  dispose() {
    taskDescriptionController.text = "";
    taskTitleController.text = "";
  }
}

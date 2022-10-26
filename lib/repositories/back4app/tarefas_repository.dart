import 'package:flutter_specialist/model/tarefas_back4app_model.dart';

import 'back4app_custom_dio.dart';

class TarefasBack4AppRepository {
  final _custom = Back4AppCustomDio();

  TarefasBack4AppRepository();

  Future<TarefasBack4AppModel> getTasks(bool naoConcluidas) async {
    var url = "/Tasks";
    if (naoConcluidas) {
      url = "$url?where={\"done\":false}";
    }
    var result = await _custom.dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criarTask(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custom.dio.post('/Tasks', data: tarefaBack4AppModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarTask(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custom.dio.put('/Tasks/${tarefaBack4AppModel.objectId}',
          data: tarefaBack4AppModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custom.dio.delete("/Tasks/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}

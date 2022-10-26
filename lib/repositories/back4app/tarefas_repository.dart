import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {
  var _dio = Dio();

  TarefasBack4AppRepository() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] = dotenv.get("BACK4APP_APLICATIONID");
    _dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get("BACK4APP_RESTAPIKEY");
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_URL");
  }

  Future<TarefasBack4AppModel> getTasks(bool naoConcluidas) async {
    var url = "/Tasks";
    if (naoConcluidas) {
      url = "$url?where={\"done\":false}";
    }
    var result = await _dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criarTask(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _dio.post('/Tasks', data: tarefaBack4AppModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarTask(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _dio.put('/Tasks/${tarefaBack4AppModel.objectId}',
          data: tarefaBack4AppModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _dio.delete("/Tasks/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}

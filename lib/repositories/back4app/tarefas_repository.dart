import 'package:dio/dio.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {
  Future<TarefasBack4AppModel> getTasks() async {
    var dio = Dio();
    var result = await dio.get("https://parseapi.back4app.com/classes/Tasks");
    return TarefasBack4AppModel.fromJson(result.data);
  }
}
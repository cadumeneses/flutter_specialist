import 'package:dio/dio.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {
  Future<TarefasBack4AppModel> getTasks(bool naoConcluidas) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "WxCODkPKNEvH67ds0DcT0ttFWD1S5IpWN7N3Kg8L";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "uoMZAf1hiF7wpD78rih9HFFek4C4gzaQaK2lg2qR";
    dio.options.headers["content-type"] = "application/json";
    var url = "https://parseapi.back4app.com/classes/Tasks";
    if (naoConcluidas) {
      url = "$url?where={\"done\":false}";
    }
    var result = await dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }
}

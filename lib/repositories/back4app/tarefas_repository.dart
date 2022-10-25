import 'package:dio/dio.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {
  Future<TarefasBack4AppModel> getTasks() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "WxCODkPKNEvH67ds0DcT0ttFWD1S5IpWN7N3Kg8L";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "uoMZAf1hiF7wpD78rih9HFFek4C4gzaQaK2lg2qR";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get("https://parseapi.back4app.com/classes/Tasks");
    return TarefasBack4AppModel.fromJson(result.data);
  }
}

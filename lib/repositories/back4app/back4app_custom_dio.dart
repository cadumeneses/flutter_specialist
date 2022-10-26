import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_specialist/repositories/back4app/dio_interceptor.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("BACK4APP_APLICATIONID");
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("BACK4APP_RESTAPIKEY");
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_URL");
    _dio.interceptors.add(DioInterceptor());
  }
}

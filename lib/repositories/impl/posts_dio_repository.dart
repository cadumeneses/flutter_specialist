import 'package:dio/dio.dart';
import 'package:flutter_specialist/model/post_model.dart';
import 'package:flutter_specialist/repositories/posts_interface_repository.dart';

class PostsDioRepository implements PostsInterfaceRepository{
  @override
  Future<List<PostsModel>> getPosts() async {
    var dio = Dio();
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    if(response.statusCode == 200) {
      return (response.data as List).map((e) => PostsModel.fromJson(e)).toList();
    }
    return [];
  }

}
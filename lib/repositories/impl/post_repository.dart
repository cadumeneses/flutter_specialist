import 'dart:convert';

import 'package:flutter_specialist/model/post_model.dart';
import 'package:flutter_specialist/repositories/posts_interface_repository.dart';
import 'package:http/http.dart' as http;

class PostRepository implements PostsInterfaceRepository{

  @override
  Future<List<PostsModel>> getPosts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode == 200) {
      var posts = jsonDecode(response.body);
      return (posts as List).map((e) => PostsModel.fromJson(e)).toList();
    }
    return [];
  }
}

import 'package:flutter_specialist/model/post_model.dart';

abstract class PostsInterfaceRepository {
  Future<List<PostsModel>> getPosts();
} 
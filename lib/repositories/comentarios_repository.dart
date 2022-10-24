import 'dart:convert';

import 'package:flutter_specialist/model/comentario_model.dart';
import 'package:http/http.dart' as http;

class ComentariosRepository {
  Future<List<ComentarioModel>> getComentarios(int postId) async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments'));
    if (response.statusCode == 200) {
      var jsonComentarios = jsonDecode(response.body);
      return (jsonComentarios as List)
          .map((e) => ComentarioModel.fromJson(e))
          .toList();
    }
    return [];
  }
}

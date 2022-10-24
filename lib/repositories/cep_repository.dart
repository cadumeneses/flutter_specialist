import 'dart:convert';

import 'package:flutter_specialist/model/cep_model.dart';
import 'package:http/http.dart' as http;

class CepRepository {
  Future<CepModel> BuscaCep(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return CepModel.fromJson(json);
    }
    return CepModel();
  }
}

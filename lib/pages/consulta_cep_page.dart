import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_specialist/repositories/cep_repository.dart';

import '../model/cep_model.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  var cepController = TextEditingController();
  var cepModel = CepModel();
  var cepRepository = CepRepository();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            const Text(
              'Consulta de CEP',
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              maxLength: 8,
              keyboardType: TextInputType.number,
              controller: cepController,
              onChanged: (String value) async {
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');

                setState(() {
                  loading = true;
                });

                cepModel = await cepRepository.BuscaCep(cep);

                setState(() {
                  loading = false;
                });
              },
            ),
            const SizedBox(height: 50),
            Text(
              '${cepModel.logradouro ?? ""} , ${cepModel.bairro ?? ""} ',
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              '${cepModel.localidade ?? ""} - ${cepModel.uf ?? ""}',
              style: const TextStyle(fontSize: 22),
            ),
            Visibility(
                visible: loading, child: const CircularProgressIndicator())
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

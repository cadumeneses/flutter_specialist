import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPage extends StatefulWidget {
  const NumerosAleatoriosSharedPage({super.key});

  @override
  State<NumerosAleatoriosSharedPage> createState() => _NumerosAleatoriosSharedPageState();
}

class _NumerosAleatoriosSharedPageState extends State<NumerosAleatoriosSharedPage> {
  int? numeroGerado;
  int? qtdCliques;
  final String chaveAleatorio = "numero-aleatorio";
  final String chaveQtdCliques = "quantidade_cliques";
  late SharedPreferences storage; 

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  void carregaDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(chaveAleatorio);
      qtdCliques =  storage.getInt(chaveQtdCliques);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de números aleátorios'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null ? "Nenhum número gerado" : numeroGerado.toString(),
                style: const TextStyle(fontSize: 40),
              ),Text(
                qtdCliques == null ? "Nenhum clique" : qtdCliques.toString(),
                style: const TextStyle(fontSize: 40),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              qtdCliques = (qtdCliques ?? 0) + 1;
            });
            storage.setInt(chaveAleatorio, numeroGerado!);
            storage.setInt(chaveQtdCliques, qtdCliques!);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

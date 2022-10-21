import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado;
  int? qtdCliques;
  final String chaveAleatorio = "numero-aleatorio";
  final String chaveQtdCliques = "quantidade_cliques";
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  void carregaDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    setState(() {
      numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
      qtdCliques = boxNumerosAleatorios.get('qtdCliques') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hive'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null
                    ? "Nenhum número gerado"
                    : numeroGerado.toString(),
                style: const TextStyle(fontSize: 40),
              ),
              Text(
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
            boxNumerosAleatorios.put('numeroGerado', numeroGerado!);
            boxNumerosAleatorios.put('qtdCliques', qtdCliques!);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

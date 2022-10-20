import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences storage;

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberNotificacao = false;
  bool temaDark = false;

  final chaveNome = "chave_nome";
  final chaveAltura = "chave_altura";
  final chaveNotificacoes = "chave_Notificacoes";
  final chaveTema = "chave_Tema";

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(chaveNome) ?? "";
      alturaController.text = (storage.getDouble(chaveAltura) ?? 0).toString();
      receberNotificacao = storage.getBool(chaveNotificacoes) ?? false;
      temaDark = storage.getBool(chaveTema) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(title: const Text('Configurações')),
        body: SizedBox(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: nomeUsuarioController,
                        decoration: const InputDecoration(
                          hintText: "Nome usúario",
                          hintStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      child: TextField(
                        controller: alturaController,
                        decoration: const InputDecoration(
                            hintText: "Altura",
                            hintStyle: TextStyle(color: Colors.green)),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
              SwitchListTile(
                title: const Text('Notificações'),
                value: receberNotificacao,
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacao = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Tema escuro'),
                value: temaDark,
                onChanged: (bool value) {
                  setState(() {
                    temaDark = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    await storage.setDouble(chaveAltura,
                        double.tryParse(alturaController.text) ?? 0);
                  } catch (e) {
                    showDialog(context: context, builder: (_){
                      return AlertDialog(
                        title: const Text("Meu app"),
                        content: const Text("Informe uma altura válida!"),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Voltar'))
                        ],
                      );
                    });
                  }
                  await storage.setString(
                      chaveNome, nomeUsuarioController.text);
                  await storage.setBool(chaveNotificacoes, receberNotificacao);
                  await storage.setBool(chaveTema, temaDark);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

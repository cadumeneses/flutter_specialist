import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/repositories/linguagens_repository.dart';
import '/repositories/nivel_repository.dart';
import '/shared/widgets/text_label.dart';

class DadosCadastraisSharedPage extends StatefulWidget {
  const DadosCadastraisSharedPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisSharedPage> createState() => _DadosCadastraisSharedPageState();
}

class _DadosCadastraisSharedPageState extends State<DadosCadastraisSharedPage> {
  var nomeController = TextEditingController(text: "");
  var dataNacimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  List<String> linguagensSelecionadas = [];
  var nivelSelecionado = "";
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  late SharedPreferences storage;
  final String CHAVE_DADOS_CADASTRAIS_NOME = "CHAVE_DADOS_CADASTRAIS_NOME";
  final String CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO =
      "CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO";
  final String CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_LINGUAGENS =
      "CHAVE_DADOS_CADASTRAIS_LINGUAGENS";
  final String CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_SALARIO =
      "CHAVE_DADOS_CADASTRAIS_SALARIO";

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = storage.getString(CHAVE_DADOS_CADASTRAIS_NOME) ?? "";
      dataNacimentoController.text = storage.getString(CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO) ?? "";
      dataNascimento = DateTime.parse(dataNacimentoController.text);
      nivelSelecionado = storage.getString(CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA) ?? "";
      linguagensSelecionadas = storage.getStringList(CHAVE_DADOS_CADASTRAIS_LINGUAGENS) ?? [];
      tempoExperiencia = storage.getInt(CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA) ?? 0;
      salarioEscolhido = storage.getDouble(CHAVE_DADOS_CADASTRAIS_SALARIO) ?? 0.0;
    });
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const TextLabel(texto: "Data de nascimento"),
                  TextField(
                      controller: dataNacimentoController,
                      readOnly: true,
                      onTap: () async {
                        var data = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1900, 5, 20),
                            lastDate: DateTime(2023, 10, 23));
                        if (data != null) {
                          dataNacimentoController.text = data.toString();
                          dataNascimento = data;
                        }
                      }),
                  const TextLabel(texto: "Nivel de experi??ncia"),
                  Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              selected: nivelSelecionado == nivel,
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  nivelSelecionado = value.toString();
                                });
                              }))
                          .toList()),
                  const TextLabel(texto: "Linguagens preferidas"),
                  Column(
                    children: linguagens
                        .map((linguagem) => CheckboxListTile(
                            dense: true,
                            title: Text(linguagem),
                            value: linguagensSelecionadas.contains(linguagem),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  linguagensSelecionadas.add(linguagem);
                                });
                              } else {
                                setState(() {
                                  linguagensSelecionadas.remove(linguagem);
                                });
                              }
                            }))
                        .toList(),
                  ),
                  const TextLabel(texto: "Tempo de experi??ncia"),
                  DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      }),
                  TextLabel(
                      texto:
                          "Preten????o Salarial. R\$ ${salarioEscolhido.round().toString()}"),
                  Slider(
                      min: 0,
                      max: 10000,
                      value: salarioEscolhido,
                      onChanged: (double value) {
                        setState(() {
                          salarioEscolhido = value;
                        });
                      }),
                  TextButton(

                    onPressed: () async{
                      setState(() {
                        salvando = false;
                      });
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("O nome deve ser preenchido")));
                        return;
                      }
                      if (dataNascimento == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data de nascimento inv??lida")));
                        return;
                      }
                      if (nivelSelecionado.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("O n??vel deve ser selecionado")));
                        return;
                      }
                      if (linguagensSelecionadas.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ser selecionado ao menos uma linguagem")));
                        return;
                      }
                      if (tempoExperiencia == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ter ao menos um ano de experi??ncia em uma das linguagens")));
                        return;
                      }
                      if (salarioEscolhido == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "A preten????o salarial deve ser maior que 0")));
                        return;
                      }

                      await storage.setString(CHAVE_DADOS_CADASTRAIS_NOME, nomeController.text);
                      await storage.setString(CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO, dataNacimentoController.text);
                      await storage.setString(CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA, nivelSelecionado);
                      await storage.setStringList(CHAVE_DADOS_CADASTRAIS_LINGUAGENS, linguagensSelecionadas);
                      await storage.setInt(CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA, tempoExperiencia);
                      await storage.setDouble(CHAVE_DADOS_CADASTRAIS_SALARIO, salarioEscolhido);

                      setState(() {
                        salvando = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Dados salvo com sucesso")));
                        setState(() {
                          salvando = false;
                        });
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
      ),
    );
  }
}

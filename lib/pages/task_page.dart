import 'package:flutter/material.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';
import 'package:flutter_specialist/repositories/back4app/tarefas_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TarefasBack4AppRepository tarefasBack4AppRepository = TarefasBack4AppRepository();
  var _tarefasBack4App = TarefasBack4AppModel([]);
  var descricaoContoller = TextEditingController();
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefasBack4App = await tarefasBack4AppRepository.getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            descricaoContoller.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar tarefa"),
                    content: TextField(
                      controller: descricaoContoller,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            // await tarefaRepository.adicionat(
                            //     TarefaModel(descricaoContoller.text, false));
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         "Apenas não concluídos",
              //         style: TextStyle(fontSize: 18),
              //       ),
              //       Switch(
              //           value: apenasNaoConcluidos,
              //           onChanged: (bool value) {
              //             apenasNaoConcluidos = value;
              //             obterTarefas();
              //           })
              //     ],
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                    itemCount: _tarefasBack4App.tarefas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _tarefasBack4App.tarefas[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          //await tarefaRepository.remove(tarefa.id);
                          obterTarefas();
                        },
                        key: Key(tarefa.description),
                        child: ListTile(
                          title: Text(tarefa.description),
                          trailing: Switch(
                            onChanged: (bool value) async {
                              //await tarefasBack4AppRepository.alterar(tarefa.id, value);
                              obterTarefas();
                            },
                            value: tarefa.done,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}

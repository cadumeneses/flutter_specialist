import 'package:flutter/material.dart';
import 'package:flutter_specialist/model/tarefas_back4app_model.dart';
import 'package:flutter_specialist/repositories/back4app/tarefas_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TarefasBack4AppRepository tarefasBack4AppRepository =
      TarefasBack4AppRepository();
  var _tarefasBack4App = TarefasBack4AppModel([]);
  var descricaoContoller = TextEditingController();
  var apenasNaoConcluidos = false;
  var loading = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      loading = true;
    });
    _tarefasBack4App =
        await tarefasBack4AppRepository.getTasks(apenasNaoConcluidos);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tarefas 123')),
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
                            Navigator.pop(context);
                            await tarefasBack4AppRepository.criarTask(
                                TarefaBack4AppModel.criar(descricaoContoller.text, false));
                            obterTarefas();
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Apenas não concluídos",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                        value: apenasNaoConcluidos,
                        onChanged: (bool value) {
                          apenasNaoConcluidos = value;
                          obterTarefas();
                        })
                  ],
                ),
              ),
              loading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _tarefasBack4App.tarefas.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var tarefa = _tarefasBack4App.tarefas[index];
                            return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await tarefasBack4AppRepository.remover(tarefa.objectId);
                                obterTarefas();
                              },
                              key: Key(tarefa.description),
                              child: ListTile(
                                title: Text(tarefa.description),
                                trailing: Switch(
                                  onChanged: (bool value) async {
                                    tarefa.done = value;
                                    await tarefasBack4AppRepository.atualizarTask(tarefa);
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

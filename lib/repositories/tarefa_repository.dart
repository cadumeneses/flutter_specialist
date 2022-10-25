import '/model/tarefa.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<void> adicionat(TarefaModel tarefa) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<TarefaModel>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas;
  }

  Future<List<TarefaModel>> listarNaoConcluidas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }
}

class TarefasBack4AppModel {
  List<Tarefa> tarefas = [];

  TarefasBack4AppModel(this.tarefas);

  TarefasBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <Tarefa>[];
      json['results'].forEach((v) {
        tarefas.add(Tarefa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class Tarefa {
  String objectId = "";
  String description = "";
  bool done = false;
  String createdAt = "";
  String updatedAt = "";

  Tarefa(
      this.objectId,
      this.description,
      this.done,
      this.createdAt,
      this.updatedAt);

  Tarefa.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    description = json['description'];
    done = json['done'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['description'] = description;
    data['done'] = done;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

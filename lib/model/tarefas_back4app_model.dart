class TarefasBack4AppModel {
  List<TarefaBack4AppModel> tarefas = [];

  TarefasBack4AppModel(this.tarefas);

  TarefasBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefaBack4AppModel>[];
      json['results'].forEach((v) {
        tarefas.add(TarefaBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaBack4AppModel {
  String objectId = "";
  String description = "";
  bool done = false;
  String createdAt = "";
  String updatedAt = "";

  TarefaBack4AppModel(this.objectId, this.description, this.done, this.createdAt,
      this.updatedAt);

  TarefaBack4AppModel.criar(this.description, this.done);

  TarefaBack4AppModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['done'] = done;
    return data;
  }
}

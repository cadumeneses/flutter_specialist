import 'package:flutter/material.dart';
import 'package:flutter_specialist/model/comentario_model.dart';
import 'package:flutter_specialist/repositories/comentarios_repository.dart';

class ComentariosPage extends StatefulWidget {
  final int postId;
  const ComentariosPage({required this.postId, super.key});

  @override
  State<ComentariosPage> createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  var comentariosRepository = ComentariosRepository();
  var cometarios = <ComentarioModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    cometarios = await comentariosRepository.getComentarios(widget.postId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comentários'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: cometarios.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cometarios.length,
                  itemBuilder: (_, int index) {
                    var comentario = cometarios[index];
                    return Card(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(comentario.name.substring(0, 6)),
                              Text(comentario.email),
                            ],
                          ),
                          Text(comentario.body),
                        ],
                      ),
                    ));
                  }),
        ),
      ),
    );
  }
}

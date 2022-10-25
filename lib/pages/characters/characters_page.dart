import 'package:flutter/material.dart';
import 'package:flutter_specialist/model/characters_model.dart';
import 'package:flutter_specialist/repositories/marvel/characters_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController _scrollController = ScrollController();
  final CharactersRepository charactersRepository = CharactersRepository();
  CharactersModel characters = CharactersModel();
  int offset = 0;
  bool carregando = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoPaginar) {
        carregarDados();
      }
    });
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (carregando) {
      return;
    }
    if (characters.data == null || characters.data!.results == null) {
      characters = await charactersRepository.getCharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + characters.data!.count!;
      var list = await charactersRepository.getCharacters(offset);
      characters.data!.results!.addAll(list.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int qtdTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int qtdAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Heróis: ${qtdAtual()}/${qtdTotal()}'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null ||
                        characters.data!.results == null)
                    ? 0
                    : characters.data!.results!.length,
                itemBuilder: (_, int index) {
                  var character = characters.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                          width: 150,
                          height: 150,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(character.description!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            !carregando
                ? ElevatedButton(
                    onPressed: () {
                      carregarDados();
                    },
                    child: const Text('Mais'),
                  )
                : const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

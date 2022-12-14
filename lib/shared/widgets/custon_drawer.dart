import 'package:flutter/material.dart';
import 'package:flutter_specialist/pages/auto_size_page.dart';
import 'package:flutter_specialist/pages/baterry_page.dart';
import 'package:flutter_specialist/pages/characters/characters_page.dart';
import 'package:flutter_specialist/pages/configuracoes/configuracoes_shared_page.dart';
import 'package:flutter_specialist/pages/numerosaleatorios/numeros_aleatorios_shared_page.dart';
import 'package:flutter_specialist/pages/posts_page.dart';
import 'package:flutter_specialist/pages/qr_code_page.dart';
import 'package:flutter_specialist/pages/task_page.dart';
import 'package:flutter_specialist/repositories/marvel/characters_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../pages/configuracoes/configuracoes_hive_page.dart';
import '../../pages/numerosaleatorios/numeros_aleatorios_hive_page.dart';
import '/pages/login_page.dart';

import '../../pages/dados_cadastrais/dados_cadastrais_hive_page.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera_alt),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.insert_photo),
                        )
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.orange),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
                ),
                accountName: const Text("Danilo Perez"),
                accountEmail: const Text("email@email.com")),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.database),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Dados cadastr??is"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DadosCadastraisHivePage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.file),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Termos de uso e privacidade"),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Column(
                        children: const [
                          Text(
                            "Termos de uso e privacidade",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Do mesmo modo, o entendimento das metas propostas prepara-nos para enfrentar situa????es at??picas decorrentes do sistema de forma????o de quadros que corresponde ??s necessidades. Todas estas quest??es, devidamente ponderadas, levantam d??vidas sobre se a consolida????o das estruturas acarreta um processo de reformula????o e moderniza????o dos conhecimentos estrat??gicos para atingir a excel??ncia. Assim mesmo, a revolu????o dos costumes deve passar por modifica????es independentemente dos ??ndices pretendidos. N??o obstante, a percep????o das dificuldades apresenta tend??ncias no sentido de aprovar a manuten????o do retorno esperado a longo prazo.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.gears),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Configura????es"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const ConfiguracoesHivePage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.hashtag),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gerador de n??meros"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const NumerosAleatoriosHivePage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.mailchimp),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Posts"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const PostsPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.mask),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Her??is"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const CharactersPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.listCheck),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Tarefas HTTP"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const TaskPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.solidFileZipper),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Auto size"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const AutoSizePage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.batteryHalf),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Bateria"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const BatteryPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.qrcode),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Qr code"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const QrCodePage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.firefox),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Abrir URL"),
                  ],
                )),
            onTap: () async {
              await launchUrl(Uri.parse('https://dio.me'));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.shareNodes),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Compartilhar"),
                  ],
                )),
            onTap: () {
              // Share.share('OLhem isso https://dio.me');
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.personThroughWindow),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sair"),
                  ],
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      alignment: Alignment.centerLeft,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text(
                        "Meu App",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Wrap(
                        children: const [
                          Text("Voce sair?? do aplicativo!"),
                          Text("Deseja realmente sair do aplicativo?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("N??o")),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text("Sim"))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

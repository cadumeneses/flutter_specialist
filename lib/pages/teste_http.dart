import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteHttpPage extends StatefulWidget {
  const TesteHttpPage({super.key});

  @override
  State<TesteHttpPage> createState() => _TesteHttpPageState();
}

class _TesteHttpPageState extends State<TesteHttpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          var reponse = await http.get(Uri.parse("https://www.google.com")).then((value) {});
        },child: const Icon(Icons.add),),
      ),
    );
  }
}
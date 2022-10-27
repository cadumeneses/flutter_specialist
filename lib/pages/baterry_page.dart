// import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  // var battery = Battery();
  var statusBateria = "";

  // @override
  // void initState() {
  //   super.initState();
  //   carregarDados();
  //   battery.onBatteryStateChanged.listen((BatteryState state) { });
  // // }

  // carregarDados() async {
  //   statusBateria = (await battery.batteryLevel).toString();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Status bateria: $statusBateria%")),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}

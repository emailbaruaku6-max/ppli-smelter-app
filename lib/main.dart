import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("PPLI Smelter App")),
        body: const Center(child: Text("Sistem Siap Beroperasi")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String status = "Menunggu...";
  List<String> daftarBarang = []; // Keranjang penampung data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String sheetId = '1N5qEnYzJzEeKTv3nvrMyTrcTI-s-7gA3NE3Q4n2KjcA'; 
    final String url = 'https://docs.google.com/spreadsheets/d/$sheetId/gviz/tq?tqx=out:json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Logika sederhana: ambil data JSON dan masukkan ke keranjang
        setState(() {
          status = "Data berhasil dimuat";
          daftarBarang = ["Barang A", "Barang B", "Barang C"]; // Simulasi data
        });
      }
    } catch (e) {
      setState(() { status = "Error: $e"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PPLI Smelter")),
      body: daftarBarang.isEmpty 
        ? Center(child: Text(status)) 
        : ListView.builder(
            itemCount: daftarBarang.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.inventory),
                title: Text(daftarBarang[index]),
              );
            },
          ),
    );
  }
}

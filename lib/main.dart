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
  String status = "Memuat data...";
  List<String> daftarBarang = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // ID Sheet milik Baginda
    final String sheetId = '1N5qEnYzJzEeKTv3nvrMyTrcTI-s-7gA3NE3Q4n2KjcA'; 
    final String url = 'https://docs.google.com/spreadsheets/d/$sheetId/gviz/tq?tqx=out:json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Membersihkan data dari JSON Google Sheets
        final jsonString = response.body.substring(47, response.body.length - 2);
        final data = jsonDecode(jsonString);
        final List rows = data['table']['rows'];
        
        setState(() {
          // Mengambil kolom pertama dari setiap baris
          daftarBarang = rows.map((row) => row['c'][0]['v'].toString()).toList();
          status = "Data berhasil dimuat";
        });
      }
    } catch (e) {
      setState(() { status = "Error: $e"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PPLI Smelter - Stok")),
      body: daftarBarang.isEmpty 
        ? Center(child: Text(status)) 
        : ListView.builder(
            itemCount: daftarBarang.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.inventory_2, color: Colors.blue),
                title: Text(daftarBarang[index]),
              );
            },
          ),
    );
  }
}

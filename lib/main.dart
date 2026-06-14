import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("PPLI Smelter - Data")),
        body: const Center(child: Text("Menyiapkan Koneksi...")),
      ),
    );
  }
}

// Fungsi ini nanti akan kita panggil untuk mengambil data
Future<void> fetchData() async {
  // Ganti ID di bawah ini dengan ID Google Sheets Baginda
  final String sheetId = '1N5qEnYzJzEeKTv3nvrMyTrcTI-s-7gA3NE3Q4n2KjcA'; 
  final String url = 'https://docs.google.com/spreadsheets/d/$sheetId/gviz/tq?tqx=out:json';
  
  final response = await http.get(Uri.parse(url));
  
  if (response.statusCode == 200) {
    print("Data berhasil diambil!");
  } else {
    print("Gagal mengambil data.");
  }
}

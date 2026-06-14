class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String status = "Menunggu perintah...";

  @override
  void initState() {
    super.initState();
    fetchData(); // Kurir dipanggil otomatis saat aplikasi dibuka
  }

  Future<void> fetchData() async {
    setState(() { status = "Sedang mengambil data..."; });
    
    final String sheetId = '1N5qEnYzJzEeKTv3nvrMyTrcTI-s-7gA3NE3Q4n2KjcA'; 
    final String url = 'https://docs.google.com/spreadsheets/d/$sheetId/gviz/tq?tqx=out:json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() { status = "Data berhasil diambil!"; });
      } else {
        setState(() { status = "Gagal mengambil data."; });
      }
    } catch (e) {
      setState(() { status = "Error: $e"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("PPLI Smelter - Data")),
        body: Center(child: Text(status)), // Status muncul di layar
      ),
    );
  }
}

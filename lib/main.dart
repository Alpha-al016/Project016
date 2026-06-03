import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 1. Tambahkan import untuk dotenv
import 'package:supabase_flutter/supabase_flutter.dart'; // 2. Tambahkan import untuk Supabase
import 'screens/dashboard_screen.dart';
import 'screens/tambah_bahan_screen.dart';
import 'screens/kategori_screen.dart';

void main() async {
  // Wajib ditambahkan jika ada kode async-await sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 3. Muat file .env yang ada di folder root proyek
    await dotenv.load(fileName: ".env");

    // 4. Inisialisasi Supabase menggunakan kredensial dari file .env
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  } catch (e) {
    // Jika file .env belum dibuat oleh temanmu, aplikasi tidak akan langsung crash,
    // melainkan memberikan log error di console.
    debugPrint("Error inisialisasi .env / Supabase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Tambahkan const di sini untuk efisiensi jika memungkinkan
      debugShowCheckedModeBanner: false,
      title: 'Koolkasku',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,

      // 🔹 HEADER
      appBar: AppBar(
        title: const Text(
          "Koolkasku",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),

      // 🔹 BODY (kotak putih + dashboard)
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: const DashboardScreen(),
      ),

      // 🔹 FLOATING BUTTON (+)
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag:
                'btn_tambah', // Ditambahkan heroTag agar tidak error jika ada 2 FAB dalam 1 screen
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TambahBahanScreen(),
                ),
              ).then((result) {
                if (result == true) {}
              });
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag:
                'btn_kategori', // Ditambahkan heroTag agar tidak error jika ada 2 FAB dalam 1 screen
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KategoriScreen()),
              ).then((result) {
                if (result == true) {}
              });
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.list),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

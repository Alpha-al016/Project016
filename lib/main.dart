import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/tambah_bahan_screen.dart';
import 'screens/kategori_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // 3. Tambahkan binding initialization
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Inisialisasi proyek Supabase kamu
  await Supabase.initialize(
    url:
        'https://mgbxrgbztdwafphjulcd.supabase.co', // Ganti dengan URL dari Dashboard Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1nYnhyZ2J6dGR3YWZwaGp1bGNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0NzU4NjMsImV4cCI6MjA5NjA1MTg2M30.Y_F3vOubaNJ3OplyJGi4Rj7cf3-mzSqzporHeFR0rTg', // Ganti dengan Anon Key dari Dashboard Supabase
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koolkasku',
      home: const MainPage(),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TambahBahanScreen()),
              ).then((result) {
                if (result == true) {}
              });
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KategoriScreen()),
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

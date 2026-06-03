import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  // Fungsi ini gunanya untuk mengambil data dari internet (Supabase)
  Future<List<Map<String, dynamic>>> ambilDataKategori() async {
    final response = await Supabase.instance.client
        .from('kategori') // Harus sama persis dengan nama tabel di Supabase
        .select();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Bahan')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ambilDataKategori(), // Memanggil fungsi di atas
        builder: (context, snapshot) {
          // 1. Jika masih loading/menunggu internet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Jika terjadi error (misal internet mati atau salah ketik nama tabel)
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // 3. Jika data kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data di database.'));
          }

          // 4. Jika sukses mengambil data, tampilkan dalam list
          final listKategori = snapshot.data!;
          return ListView.builder(
            itemCount: listKategori.length,
            itemBuilder: (context, index) {
              final item = listKategori[index];
              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(item['nama_kategori'] ?? 'Tanpa Nama'),
              );
            },
          );
        },
      ),
    );
  }
}

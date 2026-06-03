import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  // 1. FUNGSI MEMBACA DATA (READ)
  Future<List<Map<String, dynamic>>> ambilDataKategori() async {
    final response = await Supabase.instance.client
        .from('kategori') // Nama tabel di Supabase
        .select();
    return response;
  }

  // 2. FUNGSI MENAMBAH DATA (CREATE)
  Future<void> tambahDataKategori() async {
    try {
      await Supabase.instance.client.from('kategori').insert({
        'nama_kategori':
            'Kategori Baru ${DateTime.now().second}', // Mengisi nama kategori otomatis dengan detik saat ini
      });

      // Jika berhasil, refresh halaman
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil menambah data ke Supabase!')),
      );
    } catch (e) {
      // Jika gagal, tampilkan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Koneksi Supabase'),
        actions: [
          // Tombol tambah data di pojok kanan atas
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: tambahDataKategori,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ambilDataKategori(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error Terjadi:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Koneksi sukses, tapi tabel masih kosong.'),
            );
          }

          final daftarKategori = snapshot.data!;
          return ListView.builder(
            itemCount: daftarKategori.length,
            itemBuilder: (context, index) {
              final item = daftarKategori[index];
              return ListTile(
                leading: const Icon(Icons.check_circle, Colors.green),
                title: Text(item['nama_kategori'] ?? 'Tanpa Nama'),
                subtitle: Text('ID: ${item['id']}'),
              );
            },
          );
        },
      ),
    );
  }
}

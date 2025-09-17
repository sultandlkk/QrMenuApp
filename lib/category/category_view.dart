import 'package:flutter/material.dart';
import 'package:ornek_proje/category/category_view_service.dart';
import 'package:ornek_proje/models/urun_model.dart';

class CategoryView extends StatelessWidget {
  final String kategoriAdi;

  const CategoryView({super.key, required this.kategoriAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        title: Text(
          kategoriAdi,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Ana sayfaya döner
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 246, 234, 146),
              ),
              child: const Text(
                "Kategoriler",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Urun>>(
        future: CategoryViewService.loadKategoriUrunleri(kategoriAdi),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }

          final urunler = snapshot.data ?? [];

          if (urunler.isEmpty) {
            return Center(
              child: Text(
                "$kategoriAdi için ürün bulunamadı!",
                style: const TextStyle(fontSize: 20),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: urunler.length,
            itemBuilder: (context, index) {
              final urun = urunler[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          urun.resim,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${urun.fiyat} ₺",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        urun.isim,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

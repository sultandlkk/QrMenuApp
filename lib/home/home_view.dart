import 'package:flutter/material.dart';
import 'package:ornek_proje/category/category_view.dart';
import 'home_view_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewService _service = HomeViewService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Menü',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset("assets/images/Coffee-Time.jpg", width: 300),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    final masaNo = await _showMasaNumarasiDialog(context);
                    if (masaNo != null) {
                      _service.garsonCagir(masaNo);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Garson çağrıldı. Masa: $masaNo"),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                  ),
                  child: const Text("Garsonu Çağır"),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                buildKategoriRow([
                  kategoriCard("Tatlılar", "assets/images/tiramisu.jpg"),
                  kategoriCard("Sıcak İçecekler", "assets/images/cay.jpg"),
                  kategoriCard("Soğuk İçecekler", "assets/images/Kola.jpg"),
                ]),
                buildKategoriRow([
                  kategoriCard(
                    "Sandviçler",
                    "assets/images/PastirmaliSand.jpg",
                  ),
                  kategoriCard("Salatalar", "assets/images/patato_salad.jpg"),
                  kategoriCard(
                    "Atıştırmalıklar",
                    "assets/images/PatetesKizartmasi.jpg",
                  ),
                ]),
                buildKategoriRow([
                  kategoriCard("Çorbalar", "assets/images/Ezogelin.jpg"),
                  kategoriCard(
                    "Makarnalar",
                    "assets/images/KiymaliMakarna.jpg",
                  ),
                  kategoriCard("Pizzalar", "assets/images/PeynirliPizza.jpg"),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showMasaNumarasiDialog(BuildContext context) async {
    final TextEditingController masaController = TextEditingController();
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Masa numarası gir",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: masaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Örn: 5",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, masaController.text),
                child: const Text("Gönder"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildKategoriRow(List<Widget> cards) {
    return Expanded(
      child: Row(children: cards.map((card) => Expanded(child: card)).toList()),
    );
  }

  Widget kategoriCard(String isim, String resimUrl) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryView(kategoriAdi: isim),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.zero),
          child: Stack(
            children: [
              Image.asset(
                resimUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black38,
                alignment: Alignment.center,
                child: Text(
                  isim,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

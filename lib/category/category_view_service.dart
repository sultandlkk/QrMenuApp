import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/urun_model.dart';

class CategoryViewService {
  /// JSON'dan ürünleri yükler
  static Future<List<Urun>> loadKategoriUrunleri(String kategoriAdi) async {
    try {
      // JSON'u oku
      final String response = await rootBundle.loadString(
        'assets/files/data.json',
      );
      final data = json.decode(response);

      // İlgili kategoriyi çek
      final List<dynamic> urunListesi = data[kategoriAdi] ?? [];

      // JSON -> Model dönüşümü
      return urunListesi.map((json) => Urun.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Veriler yüklenemedi: $e");
    }
  }
}

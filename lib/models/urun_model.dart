class Urun {
  final String isim;
  final String resim;
  final dynamic fiyat; // bazen double, bazen int olabilir diye dynamic tuttum

  Urun({required this.isim, required this.resim, required this.fiyat});

  factory Urun.fromJson(Map<String, dynamic> json) {
    return Urun(
      isim: json["isim"] ?? "Bilinmiyor",
      resim: json["resim"] ?? "",
      fiyat: json["fiyat"] ?? 0,
    );
  }
}

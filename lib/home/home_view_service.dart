class HomeViewService {
  void garsonCagir(String masaNo) {
    // Şimdilik sadece log atalım (ileride Hive / API çağrısı koyabilirsin)
    print("Garson çağrıldı -> Masa No: $masaNo");

    // Eğer Hive kullanıyorsan buraya kaydet:
    // final box = Hive.box<String>('masalar');
    // box.add(masaNo);
  }
}

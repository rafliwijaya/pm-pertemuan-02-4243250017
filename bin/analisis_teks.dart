import 'dart:io';

void main() {
  stdout.write('Masukkan kalimat: ');
  final String teks = (stdin.readLineSync() ?? '').trim();
  if (teks.isEmpty) {
    print('Kalimat kosong.');
    return;
  }

  final String kecil = teks.toLowerCase();
  final List<String> kata =
      kecil.split(RegExp(r'[^a-z0-9]+')).where((k) => k.isNotEmpty).toList();
  final int vokal = kecil.split('').where((c) => 'aiueo'.contains(c)).length;
  final String terbalik = teks.split('').reversed.join();
  final String huruf = kata.join();
  final bool palindrom = huruf == huruf.split('').reversed.join();

  final Map<String, int> frekuensi = {};
  for (final k in kata) {
    frekuensi[k] = (frekuensi[k] ?? 0) + 1;
  }

  print('Jumlah karakter : ${teks.length}');
  print('Jumlah kata     : ${kata.length}');
  print('Jumlah vokal    : $vokal');
  print('Huruf besar     : ${teks.toUpperCase()}');
  print('Terbalik        : $terbalik');
  print('Palindrom?      : $palindrom');
  print('Kata unik       : ${kata.toSet()}');
  print('Frekuensi kata  : $frekuensi');
    final String kataTerpanjang = kata.reduce((a, b) => a.length >= b.length ? a : b);
  print('Kata terpanjang : $kataTerpanjang (${kataTerpanjang.length} huruf)');
}
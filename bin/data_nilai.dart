void main() {
  final List<({String nama, int nilai})> kelas = [
    (nama: 'Andi', nilai: 85),
    (nama: 'Butet', nilai: 72),
    (nama: 'Citra', nilai: 58),
    (nama: 'Dimas', nilai: 91),
    (nama: 'Elisa', nilai: 66),
    (nama: 'Rafli', nilai: 78),
    (nama: 'Wijaya', nilai: 95),
  ];

  // Skala contoh; sesuaikan dengan pedoman akademik yang berlaku.
  String huruf(int n) => n >= 85
      ? 'A'
      : n >= 70
          ? 'B'
          : n >= 60
              ? 'C'
              : n >= 50
                  ? 'D'
                  : 'E';

  print('${'Nama'.padRight(10)}${'Nilai'.padLeft(6)} Huruf');
  print('-' * 24);
  for (final m in kelas) {
    final baris = m.nama.padRight(10) + m.nilai.toString().padLeft(6);
    print('$baris ${huruf(m.nilai)}');
  }

  final int total = kelas.fold<int>(0, (sum, m) => sum + m.nilai);
  final double rataRata = total / kelas.length;
  final List<String> lulus =
      kelas.where((m) => m.nilai >= 60).map((m) => m.nama).toList();
  final terbaik = kelas.reduce((a, b) => a.nilai >= b.nilai ? a : b);
  final (:nama, :nilai) = terbaik; // destrukturisasi record

  print('-' * 24);
  print('Rata-rata kelas : ${rataRata.toStringAsFixed(1)}');
  print('Lulus (>= 60)   : ${lulus.join(', ')}');
  print('Nilai tertinggi : $nama ($nilai)');

  // hitung jumlah mahasiswa per nilai hururf dalam sebuah mapstring
  final Map<String, int> sebaranHuruf = {};
  for (final m in kelas) {
    final h = huruf(m.nilai);
    sebaranHuruf[h] = (sebaranHuruf[h] ?? 0) + 1;
  }
  print('-' * 24);
  print('Distribusi Huruf: $sebaranHuruf');

  // urutan daftar dari tertinggi ke terendah
  final urutanTertinggi = kelas.toList()
    ..sort((a, b) => b.nilai.compareTo(a.nilai));

  print('\n=== DAFTAR PERINGKAT KELAS ===');
  print('${'Peringkat'.padRight(10)}${'Nama'.padRight(12)}${'Nilai'.padLeft(5)}');
  print('-' * 27);
  for (var i = 0; i < urutanTertinggi.length; i++) {
    final m = urutanTertinggi[i];
    final no = '#${i + 1}'.padRight(10);
    print('$no${m.nama.padRight(12)}${m.nilai.toString().padLeft(5)}');
  }
}
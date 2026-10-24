import 'dart:io';

void main() {
  final Map<String, ({String nama, String kategori, int harga})> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  print('KATALOG TOKO');
  print('=' * 46);
  print(
    '${'Kode'.padRight(6)}${'Nama Produk'.padRight(26)}${'Harga'.padLeft(14)}',
  );
  print('-' * 46);

  for (final entry in katalog.entries) {
    final kode = entry.key;
    final produk = entry.value;
    final hargaFormatted = 'Rp ${produk.harga}';
    
    print(
      '${kode.padRight(6)}${produk.nama.padRight(26)}${hargaFormatted.padLeft(14)}',
    );
  }
  print('=' * 46);
  print('');

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final String input = stdin.readLineSync() ?? '';

  final List<({String kode, String nama, String kategori, int harga, int jumlah})> pesananValid = [];
  final List<String> itemDitolak = [];

  if (input.trim().isEmpty) {
    print('\n[Peringatan] Anda tidak memasukkan pesanan apa pun.');
  } else {
    final rawItems = input.split(',');

    for (final rawItem in rawItems) {
      final itemBersih = rawItem.trim();
      if (itemBersih.isEmpty) continue;

      final parts = itemBersih.split(RegExp(r'[xX]'));

      // Format harus tepat [kode, jumlah]
      if (parts.length != 2) {
        itemDitolak.add('$itemBersih (format salah, gunakan kodexjumlah)');
        continue;
      }

      final kode = parts[0].trim();
      final jumlahStr = parts[1].trim();

      // konfversi jumlah nullsafety
      final int? jumlah = int.tryParse(jumlahStr);
      if (jumlah == null || jumlah <= 0) {
        itemDitolak.add('$itemBersih (jumlah harus angka bulat > 0)');
        continue;
      }

      // pencarian ke katalog[kode] menghasilkan nilai bertipe nullable
      final produk = katalog[kode];
      if (produk == null) {
        itemDitolak.add('$itemBersih (kode produk tidak ditemukan)');
        continue;
      }

      // daftar pesanan valid
      pesananValid.add((
        kode: kode,
        nama: produk.nama,
        kategori: produk.kategori,
        harga: produk.harga,
        jumlah: jumlah,
      ));
    }
  }

   // hitung subtotal item menggunakan map
  final rincianPesanan = pesananValid.map((item) {
    final subtotal = item.harga * item.jumlah;
    return (
      kode: item.kode,
      nama: item.nama,
      kategori: item.kategori,
      harga: item.harga,
      jumlah: item.jumlah,
      subtotal: subtotal,
    );
  }).toList();

  // hiutng total
  final int total = rincianPesanan.fold<int>(
    0,
    (akumulator, item) => akumulator + item.subtotal,
  );

  // diskon 10%
  final int diskon = total >= 100000 ? (total * 0.10).round() : 0;
  final int totalBayar = total - diskon;

    // ambil kategori produk yg dibeli, buang duplikasi menggunakan set
  final Set<String> kategoriDibeli = rincianPesanan
      .map((item) => item.kategori)
      .toSet();
   // print daftar item yang ditolak
  if (itemDitolak.isNotEmpty) {
    print('\n[ITEM DITOLAK / GAGAL DIPROSES]');
    for (final alasan in itemDitolak) {
      print('  - $alasan');
    }
  }

  if (rincianPesanan.isEmpty) {
    print('\nTidak ada transaksi yang dapat diproses ke dalam struk.');
    return;
  }

  // certak struk pembelian
  print('\n' + '=' * 46);
  print('STRUK BELANJA');
  print('TOKO OLEH-OLEH MEDAN');
  print('=' * 46);

  for (final item in rincianPesanan) {
    print(item.nama);
    final rincianItem = '  ${item.jumlah} x Rp ${item.harga}';
    final subtotalFormatted = 'Rp ${item.subtotal}';
    print(
      '${rincianItem.padRight(30)}${subtotalFormatted.padLeft(16)}',
    );
  }

  print('-' * 46);
  print('${'Total Belanja'.padRight(30)}${'Rp $total'.padLeft(16)}');
  if (diskon > 0) {
    print('${'Diskon (10%)'.padRight(30)}${'- Rp $diskon'.padLeft(16)}');
  }
  print('${'Total Bayar'.padRight(30)}${'Rp $totalBayar'.padLeft(16)}');
  print('=' * 46);

  final kategoriTeks = kategoriDibeli.join(', ');
  print('Kategori produk yang dibeli: {$kategoriTeks}');
  print('Terima kasih telah berbelanja di Medan :)');
  print('=' * 46);
}
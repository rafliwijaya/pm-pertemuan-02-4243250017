import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Bilangan pertama            : ');
  final double? a = double.tryParse(stdin.readLineSync() ?? '');
  stdout.write('Operator (+ - * / ~/ %)     : ');
  final String op = (stdin.readLineSync() ?? '').trim();
  stdout.write('Bilangan kedua              : ');
  final double? b = double.tryParse(stdin.readLineSync() ?? '');

  // Setelah pengecekan ini, a dan b otomatis dianggap double (bukan double?).
  if (a == null || b == null) {
    print('Input bukan angka yang valid.');
    return;
  }

  // switch expression akan dibahas lengkap pada Pertemuan 3.
  final num? hasil = switch (op) {
    '+' => a + b,
    '-' => a - b,
    '*' => a * b,
    '/' => b == 0 ? null : a / b,
    '~/' => b == 0 ? null : a ~/ b,
    '%' => b == 0 ? null : a % b,
    '^' => pow(a, b),
    _ => null,
  };

  // merapikan tampilan angka (menghapus .0 kalo bilangan bulat)
  String formatAngka(num n) {
    return n == n.roundToDouble() ? n.toInt().toString() : n.toString();
  }

  final teksA = formatAngka(a);
  final teksB = formatAngka(b);
  final teksHasil = hasil != null ? formatAngka(hasil) : '';

  print(hasil == null
      ? 'Operator tidak dikenal atau pembagian dengan nol.'
      : '$teksA $op $teksB = $teksHasil');
  print(hasil == null
      ? 'Operator tidak dikenal atau pembagian dengan nol.'
      : '$a $op $b = $hasil');
}
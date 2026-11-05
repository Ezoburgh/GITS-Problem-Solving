List<int> nilaiBerbeda(List<int> papan, [int index = 0, List<int>? hasil]) {
  hasil ??= <int>[];
  if (index >= papan.length) return hasil;
  if (index == 0 || papan[index] != papan[index - 1]) {
    hasil.add(papan[index]);
  }
  return nilaiBerbeda(papan, index + 1, hasil);
}

// menghitung rank Dense dari sebuah skor terhadap papan skor.
// Dense rank = jumlah nilai berbeda yang lebih besar dari skor + 1
int denseRank(List<int> berbeda, int skor, [int index = 0]) {
  if (index >= berbeda.length) return 1;
  if (berbeda[index] > skor) {
    return denseRank(berbeda, skor, index + 1) + 1;
  }
  return 1;
}

// menghitung rank untuk seluruh skor gits lalu digabung jadi String.
String rankingGITS(List<int> papan, List<int> skorGits) {
  final berbeda = nilaiBerbeda(papan);
  return gabungRank(berbeda, skorGits, 0, '');
}

// menggabungkan rank-rank menjadi string spasi dipisah
String gabungRank(
  List<int> berbeda,
  List<int> skorGits,
  int index,
  String hasil,
) {
  if (index >= skorGits.length) return hasil;
  final rank = denseRank(berbeda, skorGits[index]);
  final baru = hasil.isEmpty ? '$rank' : '$hasil $rank';
  return gabungRank(berbeda, skorGits, index + 1, baru);
}

void main() {
  // input 1
  final List<int> papan1 = [100, 100, 50, 40, 40, 20, 10];
  final List<int> gits1 = [5, 25, 50, 120];
  print('Input : papan=${papan1} gits=${gits1}');
  print('Output: ${rankingGITS(papan1, gits1)}');
  print('');

  // input 2
  final List<int> papan2 = [100, 80, 80, 70];
  final List<int> gits2 = [60, 70, 100];
  print('Input : papan=${papan2} gits=${gits2}');
  print('Output: ${rankingGITS(papan2, gits2)}');
  print('');

  // input 3
  final List<int> papan3 = [50, 50, 50, 30, 30, 10];
  final List<int> gits3 = [50, 30, 5, 99];
  print('Input : papan=${papan3} gits=${gits3}');
  print('Output: ${rankingGITS(papan3, gits3)}');
}

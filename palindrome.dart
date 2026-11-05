const int _NINE = 57; // kode ASCII '9'
const int _NOL = 48; // kode ASCII '0'

// mengubah String menjadi List<int> kode ASCII digit.
List<int>? _keDigit(String s, int i) {
  if (i >= s.length) return <int>[];
  final c = s.codeUnitAt(i);
  if (c < _NOL || c > _NINE) return null;
  final sisa = _keDigit(s, i + 1);
  if (sisa == null) return null;
  return <int>[c, ...sisa];
}

// menghitung banyaknya pasangan yang tidak sama pada rentang
int _hitungMismatch(List<int> a, int i, int j) {
  if (i >= j) return 0;
  final beda = (a[i] != a[j]) ? 1 : 0;
  return beda + _hitungMismatch(a, i + 1, j - 1);
}

int _perbaiki(List<int> a, int i, int j, int k) {
  if (i > j) return k;
  if (i == j) {
    if (a[i] != _NINE && k >= 1) {
      a[i] = _NINE;
      return k - 1;
    }
    return k;
  }

  final x = a[i];
  final y = a[j];
  final beda = (x != y);
  final nilaiMax = (x > y) ? x : y;
  final biayaMax = beda ? 1 : 0;
  final biaya9 = (x == _NINE ? 0 : 1) + (y == _NINE ? 0 : 1); // biaya jadi '9'
  final tersisa = k - _hitungMismatch(a, i + 1, j - 1);

  if (biaya9 <= tersisa) {
    a[i] = _NINE;
    a[j] = _NINE;
    k -= biaya9;
  } else if (biayaMax <= tersisa) {
    a[i] = nilaiMax;
    a[j] = nilaiMax;
    k -= biayaMax;
  } else {
    return -1; // budget tidak cukup -> tidak ada palindrom
  }

  return _perbaiki(a, i + 1, j - 1, k);
}

// mengubah 'List<int>' kode ASCII menjadi String
String _keTeks(List<int> a, int i) {
  if (i >= a.length) return '';
  return String.fromCharCode(a[i]) + _keTeks(a, i + 1);
}

// menentukan apakah String menyatakan sebuah angka
bool _bisaAngka(String s, int i) {
  if (i >= s.length) return true;
  if (i == 0 && s.length > 1 && s.codeUnitAt(0) == _NOL) return false;
  final c = s.codeUnitAt(i);
  if (c < _NOL || c > _NINE) return false;
  return _bisaAngka(s, i + 1);
}

// fungsi utama untuk mencari palindrom terbesar dengan maksimal k perubahan
// mengembalikan "-1" bila tidak ada jawaban yang valid
String highestPalindrome(String s, int k) {
  final a = _keDigit(s, 0);
  if (a == null) return '-1'; 
  if (a.isEmpty) return '-1';

  final n = a.length;
  final sisa = _perbaiki(a, 0, n - 1, k);
  if (sisa < 0) return '-1'; 

  final hasil = _keTeks(a, 0);
  if (!_bisaAngka(hasil, 0)) return '-1';
  return hasil;
}

void main() {
  // Input 1 
  print('Input : s = "3943", k = 1');
  print('Output: ${highestPalindrome('3943', 1)}');
  print('');

  // Input 2 
  print('Input : s = "932239", k = 2');
  print('Output: ${highestPalindrome('932239', 2)}');
  print('');

  // Input 3 
  print('Input : s = "1234", k = 4');
  print('Output: ${highestPalindrome('1234', 4)}');
  print('Input : s = "0011", k = 2');
  print('Output: ${highestPalindrome('0011', 2)}');
  print('Input : s = "3943", k = 0');
  print('Output: ${highestPalindrome('3943', 0)}');
}

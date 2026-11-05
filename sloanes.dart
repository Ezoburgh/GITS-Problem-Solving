int a000124(int n) {
  if (n <= 1) return 1;
  return a000124(n - 1) + (n - 1);
}

// mengubah seluruh suku menjadi String dengan pemisah '-'
String deretA000124(int n) {
  if (n <= 0) return '';
  if (n == 1) return '${a000124(1)}';
  return '${deretA000124(n - 1)}-${a000124(n)}';
}

// menghitung panjang digit terbesar pada deret
int panjangDeret(int n) {
  if (n <= 0) return 0;
  return panjangDeret(n - 1) + 1;
}

void main() {
  // pemanggilan fungsi dengan 3 input berbeda
  final List<int> inputs = [7, 5, 10];

  for (int i = 0; i < inputs.length; i++) {
    int n = inputs[i];
    print('Input : $n');
    print('Output: ${deretA000124(n)}');
    print('');
  }
}

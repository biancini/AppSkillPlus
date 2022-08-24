// ignore_for_file: avoid_print

class Debug {
  Debug({required this.prefix});

  String prefix;

  info(String s) {
    print(prefix);
    print('--AUTH-DEBUG: $prefix $s');
  }
}

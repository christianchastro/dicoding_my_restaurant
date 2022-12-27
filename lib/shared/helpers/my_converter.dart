abstract class MyConverter {
  /// Convert value to "Rp XX.XXX.XXX" as [String]
  static String rupiah(value, {String separator = '.', String trailing = ''}) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator')}$trailing";
  }
}

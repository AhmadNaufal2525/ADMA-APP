class Constant {
  static String get baseUrl => 'https://sima-rest-api.vercel.app/api/v1';
  static String get loginPath => '/auth/signIn';
  static String get registerPath => '/auth/signUp';
  static String get logoutPath => '/auth/signOut';
  static String get peminjamanPath => '/aset/peminjaman';
  static String get pengembalianPath => '/aset/pengembalian';
  static String tagNumberPath(String tagNum) =>
      '/data/aset/tagNumber/$tagNum';
  static String peminjamanUserPath(String userId) =>
      '/aset/peminjam/$userId';
}

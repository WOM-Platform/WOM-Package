class User {
  static String dbPrivateKey = 'privateKey';
  static String dbId = 'id';
  static String dbPublicKey = 'publicKey';
  static String dbUrl = 'url';
  static String dbName = 'name';

  final String privateKey;
  final String publicKey;
  final int id;
  final String name;
  final String url;
  final String error;

  User({
    this.privateKey,
    this.publicKey,
    this.id,
    this.name,
    this.url,
    this.error,
  });

  User.fromMap(Map<String, dynamic> map)
      : this.privateKey = map[dbPrivateKey],
        this.publicKey = map[dbPublicKey],
        this.name = map[dbName],
        this.id = map[dbId],
        this.url = map[dbUrl],
        this.error = null;
}

enum UserType { Instrument, POS }

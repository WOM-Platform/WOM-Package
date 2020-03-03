abstract class Actor {
  static String dbPrivateKey = 'privateKey';
  static String dbId = 'id';
  static String dbUrl = 'url';
  static String dbName = 'name';
  final String privateKey;
  final String id;
  final String name;
  final String url;

  Actor(this.id, this.name, this.url, this.privateKey);

  Actor.fromMap(Map<String, dynamic> map)
      : this.privateKey = map[dbPrivateKey],
        this.name = map[dbName],
        this.id = map[dbId].toString(),
        this.url = map[dbUrl];

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map[dbName] = name;
    map[dbId] = id;
    map[dbUrl] = url;
    map[dbPrivateKey] = privateKey;
    return map;
  }
}

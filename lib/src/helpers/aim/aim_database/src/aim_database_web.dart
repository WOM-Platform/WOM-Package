import 'dart:html';

class AimDatabase {
  static final AimDatabase _aimDb = new AimDatabase._internal();

  AimDatabase._internal();

  static AimDatabase get() {
    return _aimDb;
  }
}

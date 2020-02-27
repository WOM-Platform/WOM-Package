import 'package:wom_package/src/models/aim.dart';

import '../../aim_api_provider.dart';

class AimRepository {
  AimApiProvider _apiProvider;

  AimRepository() {
    _apiProvider = AimApiProvider();
  }

  Future<void> updateAim({dynamic database}) async {
    print("AimRepository: updateAim()_web");
    final List<Aim> newList = await _apiProvider.checkUpdate();
  }

  Future<List<Aim>> getFlatAimList({dynamic database}) async {
    print("AimRepository: getFlatAimList()_web");
    return Future.value([]);
  }

  Future<Aim> getAim({Future<dynamic> database, String aimCode}) async {
    print("AimRepository: getAim()_web");
    return Future.value(Aim());
  }

  Future<List<Aim>> getAimList({dynamic database}) async {
    print("AimRepository: getAimList()_web");
    try {
      final list = await _apiProvider.getAims();
      return list;
    } catch (ex) {
      rethrow;
    }
  }
}

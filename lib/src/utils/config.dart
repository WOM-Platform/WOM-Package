enum Flavor {
  DEVELOPMENT,
  RELEASE,
}

class Config {
  static Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return 'http://wom.social/api/v1/';
      case Flavor.DEVELOPMENT:
        return 'http://dev.wom.social/api/v1/';
      default:
        return 'http://wom.social/api/v1/';
    }
  }

  static String get authBaseUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return 'https://wom.social/api/v2/';
      case Flavor.DEVELOPMENT:
        return 'https://dev.wom.social/api/v2/';
      default:
        return 'https://wom.social/api/v2/';
    }
  }

  static String get deepBaseUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return 'https://wom.social/';
      case Flavor.DEVELOPMENT:
        return 'https://dev.wom.social/';
      default:
        return 'https://wom.social/';
    }
  }
}

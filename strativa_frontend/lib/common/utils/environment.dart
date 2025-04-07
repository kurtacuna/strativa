import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get filename {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get appBaseUrl {
    return dotenv.env['APP_BASE_URL'] ?? "APP_BASE_URL not found.";
  }
}
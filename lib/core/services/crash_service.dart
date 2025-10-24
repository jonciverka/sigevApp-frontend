// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashService {
  static void recordError(String message, {StackTrace? stackTrace}) async {
    if (!kDebugMode || !kIsWeb) return;
    // await FirebaseCrashlytics.instance
    //     .recordError(message, stackTrace ?? StackTrace.current);
  }
}

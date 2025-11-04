import 'package:shared_preferences/shared_preferences.dart';

import 'package:sigev/config/globals.dart' as globals;

class Utilities {
  Future<void> clearCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    globals.token = '';
    globals.refresh = '';
    globals.user = null;
  }

  static bool isEmailValid(String email) {
    // Expresión regular para validar un correo electrónico
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  String getYearWeek() {
    final now = DateTime.now();
    // Ajuste según ISO 8601 (las semanas comienzan en lunes)
    final dayOfYear =
        int.parse(
          DateTime(
            now.year,
            now.month,
            now.day,
          ).difference(DateTime(now.year, 1, 1)).inDays.toString(),
        ) +
        1;
    final weekNumber = ((dayOfYear - now.weekday + 10) / 7).floor();
    return '${now.year}-W${weekNumber.toString().padLeft(2, '0')}';
  }
}

extension StringExtension on String? {
  String? get capitalize => this == null
      ? null
      : '${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}';
}

extension StringCapitalize on String {
  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

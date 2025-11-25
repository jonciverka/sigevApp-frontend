import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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

  String getYearWeek({DateTime? date}) {
    final now = date ?? DateTime.now();
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

  static DateTime getDateFromIsoWeek(String isoWeek) {
    // isoWeek viene como "2025-W46"
    final parts = isoWeek.split('-W');
    final year = int.parse(parts[0]);
    final week = int.parse(parts[1]);

    // ISO week: el 4 de enero siempre está en la semana 1
    final jan4 = DateTime(year, 1, 4);

    // Obtener el lunes de la semana 1
    final firstWeekMonday = jan4.subtract(Duration(days: jan4.weekday - 1));

    // Calcular lunes de la semana deseada
    final targetMonday = firstWeekMonday.add(Duration(days: (week - 1) * 7));

    return targetMonday; // puedes devolver targetMonday o cualquier día de esa semana
  }

  Future<File> uint8ListToFile(Uint8List data, String filename) async {
    final tempDir =
        await getTemporaryDirectory(); // 📁 /data/user/0/tu.app/cache/
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(data);
    return file;
  }

  static String formatMoney(num value) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(value);
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

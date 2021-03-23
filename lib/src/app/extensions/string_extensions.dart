import 'package:web_menu_flutter/src/app/routing/router.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String enumToString() {
    return this.split('.').last.toLowerCase().capitalize();
  }
}

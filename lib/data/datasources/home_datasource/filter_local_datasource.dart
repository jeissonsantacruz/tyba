import 'package:shared_preferences/shared_preferences.dart';

class FilterLocalDataSource {
  Future<bool> saveFilter(String filter) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool result = await prefs.setString('filter', filter);
      return result;
    } on Exception {
      return false;
    }
  }

  Future<String?> getFilter() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? filter = prefs.getString('filter');
      if (filter != null) {
        return filter;
      }
      return null;
    } on Exception {
      return null;
    }
  }
}

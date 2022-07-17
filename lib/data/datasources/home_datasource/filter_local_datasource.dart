import 'package:shared_preferences/shared_preferences.dart';

class FilterLocalDataSource {
  /// Method to save a filter to the local data
  Future<bool> saveFilter(String filter) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool result = await prefs.setString('filter', filter);
      return result;
    } on Exception {
      return false;
    }
  }

  /// Method to get a filter to the local data
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

import 'package:tyba/data/datasources/home_datasource/filter_local_datasource.dart';

class FilterRepository {
  final FilterLocalDataSource _localDataSource;

  FilterRepository({
    FilterLocalDataSource? localDataSource,
  }) : _localDataSource = localDataSource ?? FilterLocalDataSource();

  /// Method to get a filter from the local data source
  Future<String?> getFilter() async {
    return await _localDataSource.getFilter();
  }

  /// Method to set a filter in the local data source
  Future<bool> saveFilter({required String filter}) async {
    return _localDataSource.saveFilter(filter);
  }
}

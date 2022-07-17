import 'package:tyba/data/datasources/home_datasource/filter_local_datasource.dart';

class FilterRepository {
  final FilterLocalDataSource _localDataSource;

  FilterRepository({
    FilterLocalDataSource? localDataSource,
  }) : _localDataSource = localDataSource ?? FilterLocalDataSource();

  Future<String?> getFilter() async {
    return await _localDataSource.getFilter();
  }

  Future<bool> saveFilter({required String filter}) async {
    return _localDataSource.saveFilter(filter);
  }
}

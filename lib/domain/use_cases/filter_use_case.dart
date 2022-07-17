import 'package:tyba/domain/repositories/home_repositorie/filter_repository.dart';

/// Class that contains use cases specif with filter
class FilterUseCase {
  final FilterRepository _filterRepository;

  FilterUseCase({FilterRepository? filterRepository})
      : _filterRepository = filterRepository ?? FilterRepository();

  Future<String?> getFilter() async {
    return _filterRepository.getFilter();
  }

  Future<bool> setFilter(String filter) async {
    return _filterRepository.saveFilter(filter: filter);
  }
}

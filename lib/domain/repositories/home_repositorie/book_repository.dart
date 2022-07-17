import 'package:tyba/data/datasources/home_datasource/home_remote_datasource.dart';
import 'package:tyba/data/models/home/book.dart';

class BooksRepository {
  final BooksRemoteDataSource _remoteDataSource;

  BooksRepository({BooksRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? BooksRemoteDataSource();

  /// Method to get a books from the remote data source
  Future<List<Book>> getBooks(String query, String filter) async {
    return _remoteDataSource.getBooks(query, filter);
  }

  /// Method to get a detail book from the remote data source
  Future<String> getDetailBook(String detailId) async {
    return _remoteDataSource.getDetailBook(detailId);
  }
}

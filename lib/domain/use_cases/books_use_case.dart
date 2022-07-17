import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/domain/repositories/home_repositorie/book_repository.dart';

/// Class that contains use cases specif with books
class BooksUseCase {
  final BooksRepository _registerRepository;

  BooksUseCase({BooksRepository? registerRepository})
      : _registerRepository = registerRepository ?? BooksRepository();

  Future<List<Book>> getBooks(String query, String filter) async {
    return _registerRepository.getBooks(query, filter);
  }

  Future<String> getDetailBook(String detailId) async {
    return _registerRepository.getDetailBook(detailId);
  }
}

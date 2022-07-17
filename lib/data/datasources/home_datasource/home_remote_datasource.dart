import 'package:dio/dio.dart';
import 'package:tyba/data/models/home/book.dart';

class BooksRemoteDataSource {
  var dio = Dio();

// Future that get book by query
  Future<List<Book>> getBooks(String query, String filter) async {
    Response response =
        await dio.get('http://openlibrary.org/search.json?$filter=$query');

    List<dynamic> rawListData = response.data['docs'];
    final list = rawListData.map((p) => Book.fromJson(p)).toList();
    return list;
  }
// Future that get book detail

  Future<String> getDetailBook(String detailId) async {
    Response response = await dio.get('https://openlibrary.org$detailId.json');

    String detail = response.data['description'];

    return detail;
  }
}

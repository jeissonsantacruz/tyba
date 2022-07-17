import 'package:dio/dio.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/presentation/utils/constants.dart';

class BooksRemoteDataSource {
  var dio = Dio();

// Future that get book by query
  Future<List<Book>> getBooks(String query, String filter) async {
    Response response =
        await dio.get('$kOpenLibraryApi/search.json?$filter=$query&limit=50');

    List<dynamic> rawListData = response.data['docs'];
    final list = rawListData.map((p) => Book.fromJson(p)).toList();
    return list;
  }

  // Future that get book detail
  Future<String> getDetailBook(String detailId) async {
    Response response = await dio.get('$kOpenLibraryApi$detailId.json');

    String detail = response.data['description'];

    return detail;
  }
}

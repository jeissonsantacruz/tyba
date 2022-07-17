import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;
import 'package:tyba/presentation/screens/home/ui/book_detail.dart';
import 'package:tyba/presentation/utils/constants.dart';

// class that contains the list of  book by  query
class BuildList extends StatelessWidget {
  final List<Book> book;
  final bloc.BookBloc blocProvider;
  const BuildList({Key? key, required this.book, required this.blocProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<bloc.BookBloc, bloc.State>(
      bloc: blocProvider,
      builder: (context, state) {
        if (state is bloc.OnChangeState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          height: size.height * 0.8,
          child: book.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: book
                      .map(
                        (item) => CustomCardBook(
                          book: item,
                          blocProvider: blocProvider,
                        ),
                      )
                      .toList(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      kEmptyMessage,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

//Show a custom card with image of book , title book and  option to save a book
class CustomCardBook extends StatelessWidget {
  final Book book;
  final bloc.BookBloc blocProvider;
  const CustomCardBook(
      {Key? key, required this.book, required this.blocProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(book, blocProvider),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: book.key ?? kEmptyString,
            child: Container(
              height: 160,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(kOpenLibraryImage +
                        (book.coverI).toString() +
                        '-M.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            book.title ?? kEmptyString,
            maxLines: 1,
            style: GoogleFonts.catamaran(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;
import 'package:tyba/presentation/screens/home/ui/book_detail.dart';

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
          height: size.height * 0.7,
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
                      ' Ups! No hay  libros que coincidan \n con la busqueda!',
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
    print(book.coverI);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(book, blocProvider),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: book.key as Object,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://covers.openlibrary.org/b/id/' +
                                    (book.coverI).toString() +
                                    '-M.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(130, 10),
                    child: InkWell(
                      onTap: () {
                        // blocProvider.add(
                        //   bloc.SaveBookEvent(book: book),
                        // );
                      },
                      child: Container(
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              book.title ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                shadows: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

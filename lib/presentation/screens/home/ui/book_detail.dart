import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;
import 'package:tyba/presentation/utils/constants.dart';

// Class that contains the book detail
class DetailPage extends StatefulWidget {
  final Book book;
  final bloc.BookBloc blocProvider;

  const DetailPage(this.book, this.blocProvider, {Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  @override
  void initState() {
    widget.blocProvider.add(
      bloc.DetailBookEvent(category: widget.book.key ?? ""),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<bloc.BookBloc, bloc.State>(
      bloc: widget.blocProvider,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                widget.book.title ?? kEmptyString,
                style: const TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              )),
          body: Column(
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Container(
                  height: size.height * 0.6,
                  padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        kOpenLibraryImage +
                            (widget.book.coverI).toString() +
                            '-L.jpg',
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      imageBook(),
                      const SizedBox(
                        height: 30,
                      ),
                      titleBook(),
                      const SizedBox(
                        height: 30,
                      ),
                      infoBook()
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child:
                    descriptionBook(state.model.detail ?? kEmptyString, size),
              ),
              Flexible(
                flex: 1,
                child: goExternalDetail(),
              )
            ],
          ),
        );
      },
    );
  }

  // Show the pincipal image of book detail
  Widget imageBook() {
    return Align(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: widget.book.key ?? "",
        child: Material(
          elevation: 15.0,
          shadowColor: Colors.white,
          child: Image.network(
            kOpenLibraryImage + (widget.book.coverI).toString() + '-L.jpg',
            fit: BoxFit.cover,
            height: 200,
          ),
        ),
      ),
    );
  }
  // Show the title of book detail

  Widget titleBook() {
    return Text(
      widget.book.title ?? kEmptyString,
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
    );
  }
  // Show the  autor and published year of book detail

  Widget infoBook() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.book.authorName != null && widget.book.authorName!.isNotEmpty
              ? Text(
                  widget.book.authorName![0],
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )
              : Container(),
          Container(
            width: 2,
            height: 10,
            color: Colors.white,
          ),
          Text(
            widget.book.firstPublishYear.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
  // Show the descriction of book detail

  Widget descriptionBook(String detail, Size size) {
    return SizedBox(
      height: size.height * 0.2,
      child: SingleChildScrollView(
        child: ListTile(
          title: const Text(
            'Descripción',
            style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.white),
          ),
          subtitle: Text(
            detail,
            style: const TextStyle(
                fontSize: 13.0, height: 1.5, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Show the botton for save a book
  Widget goExternalDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton(
        child: const ListTile(
          title: Text('Detalle en la Web'),
          leading: Icon(Icons.bookmark_border),
        ),
        onPressed: () {
          widget.blocProvider.add(
            bloc.ExternalDetailBookEvent(
                search: widget.book.title ?? kEmptyString),
          );
        },
      ),
    );
  }
}

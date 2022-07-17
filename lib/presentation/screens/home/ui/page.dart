import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;
import 'package:tyba/presentation/screens/home/ui/book_list.dart';
import 'package:tyba/presentation/screens/home/ui/filter_buttons.dart';
import 'package:tyba/presentation/utils/constants.dart';
import 'package:tyba/presentation/utils/widgets/loading_widget.dart';

// Class that contains the  SingUp Screem
class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final blocProvider = bloc.BookBloc()..add(bloc.InitEvent());
  @override
  void initState() {
    blocProvider.stream.listen((state) {
      if (state is bloc.ErrorState) {
        Navigator.pop(context);
      }

      if (state is bloc.LoadingDetailState) {
        LoadingWidget.show(context);
      }

      if (state is bloc.LoadedDetailState) {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bloc.BookBloc, bloc.State>(
      bloc: blocProvider,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Libros',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8),
              ),
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextField(
                key: Key('Search'),
                onSubmitted: (value) {
                  blocProvider.add(
                    bloc.ChangeEvent(search: value),
                  );
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Buscar",
                  filled: true,
                  fillColor: Color(0XFF2A2D37),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
              FilterButtonsWidget(
                blocProvider: blocProvider,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => blocProvider.add(
                    bloc.InitEvent(),
                  ),
                  child: BuildList(
                      book: state.model.books ?? <Book>[],
                      blocProvider: blocProvider),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

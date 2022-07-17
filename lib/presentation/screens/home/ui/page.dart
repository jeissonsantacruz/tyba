import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 56, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        blocProvider.add(
                          bloc.ChangeEvent(search: value),
                        );
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: kSearch,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: kBlueyGrey, width: 0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: kBlueyGrey, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: kBlueyGrey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      kDiscoverBooks,
                      style: GoogleFonts.catamaran(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        height: 1,
                      ),
                    ),
                    FilterButtonsWidget(
                      blocProvider: blocProvider,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
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

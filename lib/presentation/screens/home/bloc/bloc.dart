import 'package:bloc/bloc.dart' as bloc;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:tyba/data/models/home/book.dart';
import 'package:tyba/domain/use_cases/books_use_case.dart';
import 'package:tyba/domain/use_cases/filter_use_case.dart';
import 'package:url_launcher/url_launcher.dart';

part 'event.dart';
part 'state.dart';

// Class that contains the  bloc of singup user
class BookBloc extends bloc.Bloc<Event, State> {
  final BooksUseCase booksUseCase;
  final FilterUseCase filterUseCase;
  BookBloc([BooksUseCase? booksUseCase, FilterUseCase? filterUseCase])
      : booksUseCase = booksUseCase ??= BooksUseCase(),
        filterUseCase = filterUseCase ??= FilterUseCase(),
        super(initialState);

  static State get initialState => const InitialState(
        Model(),
      );

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (event is InitEvent) {
      yield* _initEvent(event);
    } else if (event is DetailBookEvent) {
      yield* _detailBook(event);
    } else if (event is ChangeEvent) {
      yield* _searchEvent(event);
    } else if (event is SelectFilterEvent) {
      yield* _selectFilterEvent(event);
    } else if (event is ExternalDetailBookEvent) {
      yield* _externalDetailBook(event);
    }
  }

  // Stream that get the books with a initial search
  Stream<State> _initEvent(InitEvent event) async* {
    try {
      yield LoadingState(state.model);
      final String? filter = await filterUseCase.getFilter();

      final books =
          await booksUseCase.getBooks(state.model.search, state.model.filter);
      yield LoadedState(
        state.model.copyWith(books: books, filter: filter ?? 'q'),
      );
    } catch (error) {
      yield ErrorState(
        state.model,
        error: error.toString(),
      );
    }
  }

  // Stream that get the detail of book
  Stream<State> _detailBook(DetailBookEvent event) async* {
    try {
      yield LoadingDetailState(state.model);
      final detail = await booksUseCase.getDetailBook(event.category);
      yield LoadedDetailState(
        state.model.copyWith(detail: detail),
      );
    } catch (error) {
      yield ErrorState(
        state.model,
        error: error.toString(),
      );
    }
  }

  // Stream that change the query to search book
  Stream<State> _searchEvent(ChangeEvent event) async* {
    try {
      yield OnChangeState(state.model);
      final result = await booksUseCase.getBooks(
          event.search.replaceAll(' ', '+'), state.model.filter);
      final List<Book> books = [];
      for (Book i in result) {
        if (i.coverI != null) books.add(i);
      }
      yield OnChangedState(
        state.model.copyWith(
          search: event.search,
          books: books,
        ),
      );
    } catch (error) {
      yield ErrorState(
        state.model,
        error: error.toString(),
      );
    }
  }

  // Stream that set a filter
  Stream<State> _selectFilterEvent(SelectFilterEvent event) async* {
    try {
      await filterUseCase.setFilter(event.filter);
      yield SelectFilterState(
        state.model.copyWith(filter: event.filter),
      );
    } catch (error) {
      yield ErrorState(
        state.model,
        error: error.toString(),
      );
    }
  }

  Stream<State> _externalDetailBook(ExternalDetailBookEvent event) async* {
    try {
      yield LoadingState(state.model);
      _launchURL(event.search);
      yield LoadedState(state.model);
    } catch (error) {
      yield ErrorState(
        state.model,
        error: error.toString(),
      );
    }
  }

  /// Method to launch the external detail book
  Future<void> _launchURL(String search) async {
    final Uri _url = Uri.parse('https://www.google.com/search?q=$search');

    await canLaunchUrl(_url)
        ? await launchUrl(_url)
        : throw 'Could not launch $_url';
  }
}

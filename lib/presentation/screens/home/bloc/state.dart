part of 'bloc.dart';

@immutable
abstract class State extends Equatable {
  final Model model;
  const State(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends State {
  const InitialState(Model model) : super(model);
}

class LoadingState extends State {
  const LoadingState(Model model) : super(model);
}

class LoadedState extends State {
  const LoadedState(Model model) : super(model);
}

class LoadingDetailState extends State {
  const LoadingDetailState(Model model) : super(model);
}

class LoadedDetailState extends State {
  const LoadedDetailState(Model model) : super(model);
}

class OnChangeState extends State {
  const OnChangeState(Model model) : super(model);
}

class OnChangedState extends State {
  const OnChangedState(Model model) : super(model);
}

class SelectFilterState extends State {
  const SelectFilterState(Model model) : super(model);
}

class DetailBookState extends State {
  const DetailBookState(Model model) : super(model);
}

class ErrorState extends State {
  final String error;
  const ErrorState(Model model, {required this.error}) : super(model);

  @override
  List<Object> get props => [error];
}

class FailureDownloadingState extends State {
  final String error;
  const FailureDownloadingState({
    required Model model,
    required this.error,
  }) : super(model);

  @override
  List<Object> get props => [error, model];
}

/// Dta model that contains all data of bloc
class Model extends Equatable {
  final List<Book>? books;
  final String? detail;
  final String search;
  final String filter;

  const Model(
      {this.books,
      this.detail = 'No hay descripción para este libro :(',
      this.filter = 'q',
      this.search = ''});

  Model copyWith(
          {List<Book>? books,
          String? detail,
          String? search,
          String? filter}) =>
      Model(
        detail: detail ?? this.detail,
        books: books ?? this.books,
        search: search ?? this.search,
        filter: filter ?? this.filter,
      );

  @override
  List<dynamic> get props => [books, detail, search, filter];
}

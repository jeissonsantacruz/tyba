part of 'bloc.dart';

abstract class Event extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends Event {}

class ChangeEvent extends Event {
  final String search;
  ChangeEvent({required this.search});
}

class SelectFilterEvent extends Event {
  final String filter;
  SelectFilterEvent({required this.filter});
}

class DetailBookEvent extends Event {
  final String category;
  DetailBookEvent({required this.category});
}

part of 'bloc.dart';

abstract class Event extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends Event {}

/// Event to search
class ChangeEvent extends Event {
  final String search;
  ChangeEvent({required this.search});
}

/// Event to select a filter
class SelectFilterEvent extends Event {
  final String filter;
  SelectFilterEvent({required this.filter});
}

/// Event to see a external detail of book
class ExternalDetailBookEvent extends Event {
  final String search;
  ExternalDetailBookEvent({required this.search});
}

/// Event to see a detail of book
class DetailBookEvent extends Event {
  final String category;
  DetailBookEvent({required this.category});
}

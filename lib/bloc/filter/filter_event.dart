part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class SearchFilterkeyEvent extends FilterEvent {
  final String searchKey;
  SearchFilterkeyEvent({
    required this.searchKey,
  });
}

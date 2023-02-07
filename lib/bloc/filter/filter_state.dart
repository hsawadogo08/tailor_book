part of 'filter_bloc.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class SearchFilterkeyState extends FilterState {
  final String searchKey;
  SearchFilterkeyState({
    required this.searchKey,
  });
}

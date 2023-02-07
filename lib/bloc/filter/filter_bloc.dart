import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<SearchFilterkeyEvent>((event, emit) {
      emit(
        SearchFilterkeyState(
          searchKey: event.searchKey,
        ),
      );
    });
  }
}

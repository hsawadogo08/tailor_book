// Event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/services/type_measurement.service.dart';

abstract class DynamicEvent {}

class DynamicFormEvent extends DynamicEvent {
  final String docId;
  DynamicFormEvent({
    required this.docId,
  });
}

// States
abstract class DynamicStates {}

class DynamicSuccessState extends DynamicStates {
  final List<Map<String, dynamic>> fields;

  DynamicSuccessState({
    required this.fields,
  });
}

class DynamicErrorState extends DynamicStates {
  final String errorMessage;
  DynamicErrorState({
    required this.errorMessage,
  });
}

class DynamicInitialState extends DynamicStates {}

class DynamicLoadingState extends DynamicStates {}

// Bloc
class DynamicFormBloc extends Bloc<DynamicEvent, DynamicStates> {
  DynamicFormBloc() : super(DynamicInitialState()) {
    on((DynamicFormEvent event, emit) async {
      if (event.docId == "") {
        emit(
          DynamicErrorState(errorMessage: "Type de tenue introuvable !"),
        );
      } else {
        emit(DynamicLoadingState());
        List<Map<String, dynamic>> fields = [];
        Map<String, dynamic> data =
            await TypeMeasurementService.getTypeMeasurementByDocId(event.docId);
        data.forEach(
          (key, value) {
            fields.add(value);
          },
        );
        emit(
          DynamicSuccessState(fields: fields),
        );
      }
    });
  }
}

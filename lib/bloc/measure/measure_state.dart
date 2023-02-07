import 'package:meta/meta.dart';

import '../../models/measurement.model.dart';

@immutable
abstract class MeasureStates {}

class MeasureSuccessState extends MeasureStates {
  final String successMessage;
  MeasureSuccessState({
    required this.successMessage,
  });
}

class MeasureLinkSuccessState extends MeasureStates {
  final String successMessage;
  MeasureLinkSuccessState({
    required this.successMessage,
  });
}

class SaveMeasureSuccessState extends MeasureStates {
  final String successMessage;
  SaveMeasureSuccessState({
    required this.successMessage,
  });
}

class SearchMeasureSuccessState extends MeasureStates {
  final List<Measurement> measures;
  SearchMeasureSuccessState({
    required this.measures,
  });
}

class MeasureAmoutSuccessState extends MeasureStates {
  final Map<String, dynamic> amount;
  MeasureAmoutSuccessState({
    required this.amount,
  });
}

class MeasureErrorState extends MeasureStates {
  final String errorMessage;
  MeasureErrorState({
    required this.errorMessage,
  });
}

class MeasureLinkErrorState extends MeasureStates {
  final String errorMessage;
  MeasureLinkErrorState({
    required this.errorMessage,
  });
}

class MeasureInitialState extends MeasureStates {}

class MeasureLoadingState extends MeasureStates {}

class MeasureLinkLoadingState extends MeasureStates {}

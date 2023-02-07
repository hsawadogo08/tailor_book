import 'package:meta/meta.dart';

import '../../models/measurement.model.dart';
import '../../models/personnel.model.dart';

@immutable
abstract class MeasureEvent {}

class SaveMeasureEvent extends MeasureEvent {
  final Measurement measurement;
  SaveMeasureEvent({
    required this.measurement,
  });
}

class SearchMeasuresEvent extends MeasureEvent {
  final int size;
  final String status;
  SearchMeasuresEvent({
    this.size = 10,
    this.status = '',
  });
}

class MeasureAmoutEvent extends MeasureEvent {}

class UpdateMeasurementStatusEvent extends MeasureEvent {
  final String measureId;
  final String status;
  UpdateMeasurementStatusEvent({
    required this.measureId,
    required this.status,
  });
}

class DeleteMeasurement extends MeasureEvent {
  final Measurement measurement;
  DeleteMeasurement({
    required this.measurement,
  });
}

class AffectationMeasurementEvent extends MeasureEvent {
  final String measureId;
  final Personnel personnel;
  AffectationMeasurementEvent({
    required this.measureId,
    required this.personnel,
  });
}

class MeasureInitialEvent extends MeasureEvent {}

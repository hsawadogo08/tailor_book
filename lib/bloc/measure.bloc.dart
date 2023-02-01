// Events
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/services/measure.service.dart';

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

// States
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

// Bloc
class MeasureBloc extends Bloc<MeasureEvent, MeasureStates> {
  MeasureBloc() : super(MeasureInitialState()) {
    on((SaveMeasureEvent event, emit) async {
      emit(
        MeasureLoadingState(),
      );

      try {
        String response = await MeasureService.save(event.measurement);
        log(response);
        emit(
          SaveMeasureSuccessState(
            successMessage:
                "Les mesures de ${event.measurement.customer?.firstName} ont été enregistrées avec succès !",
          ),
        );
      } on Exception catch (_, e) {
        log("$e");
        emit(
          MeasureErrorState(
            errorMessage:
                "Une erreur est survenue lors de l'enregistrement de la mésure !",
          ),
        );
      }
    });

    on((SearchMeasuresEvent event, emit) async {
      emit(
        MeasureLoadingState(),
      );

      try {
        QuerySnapshot<Object?> response = await MeasureService.getAllMeasures();
        List<Measurement> measures = response.docs
            .map((e) => Measurement.fromDocumentSnapshot(e))
            .toList();
        log("$measures");
        emit(
          SearchMeasureSuccessState(measures: measures),
        );
      } on Exception catch (_, e) {
        log("$e");
        emit(
          MeasureErrorState(
            errorMessage:
                "Une erreur est survenue lors de la récupération des mésures !",
          ),
        );
      }
    });

    on((UpdateMeasurementStatusEvent event, emit) async {
      if (event.measureId == '') {
        emit(
          MeasureErrorState(errorMessage: "La mesure est introuvable !"),
        );
      } else if (event.status == '') {
        emit(
          MeasureErrorState(errorMessage: "Le status est introuvable !"),
        );
      } else {
        emit(MeasureLoadingState());
        try {
          await MeasureService.updateStatus(event.measureId, event.status);
          emit(
            MeasureSuccessState(
              successMessage: "Le statut a été mis à jour avec succès !",
            ),
          );
        } on Exception catch (_, e) {
          log("Update Error ==> $e");
          emit(
            MeasureErrorState(
              errorMessage:
                  "Une erreur est survenue lors du changement de statut de la mesure !",
            ),
          );
        }
      }
    });

    on((DeleteMeasurement event, emit) async {
      emit(MeasureLoadingState());
      try {
        await MeasureService.delete(event.measurement);
        emit(
          MeasureSuccessState(
            successMessage: "La mesure a été supprimée avec succès !",
          ),
        );
      } on Exception catch (_, e) {
        log("Delete Error ==> $e");
        emit(
          MeasureErrorState(
            errorMessage:
                "Une erreur est survenue lors de la suppression de la mesure !",
          ),
        );
      }
    });

    on((AffectationMeasurementEvent event, emit) async {
      if (event.personnel.id == null || event.personnel.id == "") {
        emit(
          MeasureLinkErrorState(
            errorMessage: "Veuillez choisir le personnel à affecter !",
          ),
        );
      } else {
        emit(MeasureLinkLoadingState());
        try {
          await MeasureService.doLinkToPersonnal(
            event.measureId,
            event.personnel,
          );
          emit(
            MeasureLinkSuccessState(
              successMessage: "La mesure a été affectée avec succès !",
            ),
          );
        } on Exception catch (_, e) {
          log("Affectation Error ==> $e");
          emit(
            MeasureLinkErrorState(
              errorMessage:
                  "Une erreur est survenue lors de la suppression de la mesure !",
            ),
          );
        }
      }
      // emit(MeasureInitialState());
    });
  }
}

class MeasureAmountBloc extends Bloc<MeasureEvent, MeasureStates> {
  MeasureAmountBloc() : super(MeasureInitialState()) {
    on(
      (MeasureAmoutEvent event, emit) async {
        emit(
          MeasureLoadingState(),
        );

        try {
          QuerySnapshot<Object?> response =
              await MeasureService.getAllMeasures();
          List<Measurement> measures = response.docs
              .map((e) => Measurement.fromDocumentSnapshot(e))
              .toList();

          int totalAmount = 0;
          int advancedAmount = 0;
          for (var element in measures) {
            totalAmount = totalAmount + element.totalPrice!;
            advancedAmount = advancedAmount + element.advancedPrice!;
          }

          Map<String, dynamic> amount = {
            "amount": advancedAmount,
            "credit": totalAmount - advancedAmount,
          };

          log("$amount");

          emit(
            MeasureAmoutSuccessState(
              amount: amount,
            ),
          );
        } on Exception catch (_, e) {
          log("$e");
          emit(
            MeasureErrorState(
              errorMessage:
                  "Une erreur est survenue lors de la récupération des mésures !",
            ),
          );
        }
      },
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/services/personnel.service.dart';

abstract class PersonnelEvent {}

class SearchPersonnelEvent extends PersonnelEvent {}

class SavePersonnelEvent extends PersonnelEvent {
  final Personnel personnel;
  SavePersonnelEvent({
    required this.personnel,
  });
}

// States,
abstract class PersonnelStates {}

class SearchPersonnelSuccessState extends PersonnelStates {
  final List<Personnel> personnels;
  SearchPersonnelSuccessState({
    required this.personnels,
  });
}

class SavePersonnelSuccessState extends PersonnelStates {
  final String successMessage;
  SavePersonnelSuccessState({
    required this.successMessage,
  });
}

class PersonnelErrorState extends PersonnelStates {
  final String errorMessage;
  PersonnelErrorState({
    required this.errorMessage,
  });
}

class PersonnelInitialState extends PersonnelStates {}

class PersonnelLoadingState extends PersonnelStates {}

// Bloc
class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelStates> {
  PersonnelBloc() : super(PersonnelInitialState()) {
    on((SearchPersonnelEvent event, emit) async {
      emit(PersonnelLoadingState());

      try {
        QuerySnapshot<Object?> response = await PersonnelService.getAll();
        List<Personnel> personnels = response.docs
            .map((e) => Personnel.fromDocumentSnapshot(e))
            .toList();
        emit(
          SearchPersonnelSuccessState(personnels: personnels),
        );
      } on Exception catch (_, e) {
        log("$e");
        emit(
          PersonnelErrorState(
            errorMessage:
                "Une erreur est survenue lors de la récupération de la liste du personnel !",
          ),
        );
      }
    });

    on((SavePersonnelEvent event, emit) async {
      emit(PersonnelLoadingState());
      if (event.personnel.lastName == "") {
        emit(
          PersonnelErrorState(
              errorMessage: "Le nom du personnel est obligatoire !"),
        );
      } else if (event.personnel.firstName == "") {
        emit(
          PersonnelErrorState(
              errorMessage: "Le prénom du personnel est obligatoire !"),
        );
      } else {
        try {
          await PersonnelService.save(event.personnel);
          emit(
            SavePersonnelSuccessState(
              successMessage:
                  "Le personnel ${event.personnel.lastName} ${event.personnel.firstName} a été enregistré avec succès !",
            ),
          );
        } on Exception catch (_, e) {
          log("Save Error ==> $e");
        }
      }
    });
  }
}

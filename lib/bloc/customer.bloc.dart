import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/services/customer.service.dart';

abstract class CustomerEvent {}

class SearchCustomerEvent extends CustomerEvent {}

// States
abstract class CustomerStates {}

class SearchCustomerSuccessState extends CustomerStates {
  final List<Customer> customers;
  SearchCustomerSuccessState({
    required this.customers,
  });
}

class CustomerErrorState extends CustomerStates {
  final String errorMessage;
  CustomerErrorState({
    required this.errorMessage,
  });
}

class CustomerInitialState extends CustomerStates {}

class CustomerLoadingState extends CustomerStates {}

// Bloc
class CustomerBloc extends Bloc<CustomerEvent, CustomerStates> {
  CustomerBloc() : super(CustomerInitialState()) {
    on((SearchCustomerEvent event, emit) async {
      emit(CustomerLoadingState());

      try {
        QuerySnapshot<Object?> response = await CustomerService.getAll();
        List<Customer> customers =
            response.docs.map((e) => Customer.fromDocumentSnapshot(e)).toList();
        emit(
          SearchCustomerSuccessState(customers: customers),
        );
      } on Exception catch (_, e) {
        log("$e");
        emit(
          CustomerErrorState(
              errorMessage:
                  "Une erreur est survenue lors de la récupération des clients !"),
        );
      }
    });
  }
}

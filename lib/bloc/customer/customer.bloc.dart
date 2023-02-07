import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';

import '../../models/customer.model.dart';
import '../../services/customer.service.dart';
import 'customer_event.dart';
import 'customer_state.dart';

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

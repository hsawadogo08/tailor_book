import 'package:flutter/cupertino.dart';

import '../../models/customer.model.dart';

@immutable
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

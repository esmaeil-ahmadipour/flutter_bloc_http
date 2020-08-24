import 'package:flutter/material.dart';
import 'package:flutterblochttp/data/model/api_result_model.dart';
import 'package:meta/meta.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  List<Product> productsList;

  ProductLoadedState({@required this.productsList});
}

class ProductErrorState extends ProductState {
  String message;

  ProductErrorState({@required this.message});
}

import 'package:flutter/material.dart';

class Product {
  final String productName;
  final int id;
  final String price;
  final String imageUrl;

  bool off;
  final String description;

  Product(
      {@required this.productName,
      @required this.id,
      @required this.price,
      @required this.imageUrl,
      this.off,
      @required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      id: json['id'],
      price: json['price'],
      imageUrl: json['image_url'],
      off: json['off'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['id'] = this.id;
    data['price'] = this.price;
    data['image_url'] = this.imageUrl;
    data['off'] = this.off;
    data['description'] = this.description;
    return data;
  }
}

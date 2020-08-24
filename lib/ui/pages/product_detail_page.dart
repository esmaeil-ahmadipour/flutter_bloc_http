import 'package:flutter/material.dart';
import 'package:flutterblochttp/data/model/api_result_model.dart';

class ProductDetailPage extends StatelessWidget {
 final Product product;

  ProductDetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("محصول انتخابی"),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: <Widget>[
          Image.network(product.imageUrl),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4.0),
            child: Text(
              product.description,
              style: TextStyle(fontSize: 20.0),textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

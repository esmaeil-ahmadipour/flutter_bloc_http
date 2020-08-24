import 'dart:convert';
import 'package:flutterblochttp/data/model/api_result_model.dart';
import 'package:flutterblochttp/res/strings.dart';
import 'package:http/http.dart' as http;
import '../../res/strings.dart';
import '../model/api_result_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {

    final response = await http.get(AppStrings.newsUrl);
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      List<dynamic> body = jsonDecode(source);
            List<Product> posts = body
          .map(
            (dynamic item) => Product.fromJson(item),
      )
          .toList();
    return posts;
    } else {
      // then throw an exception.
      throw Exception('Failed to loading.');
    }
  }
}

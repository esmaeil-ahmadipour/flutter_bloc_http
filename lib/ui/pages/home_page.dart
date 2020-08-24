import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblochttp/bloc/product_bloc.dart';
import 'package:flutterblochttp/bloc/product_event.dart';
import 'package:flutterblochttp/bloc/product_state.dart';
import 'package:flutterblochttp/data/model/api_result_model.dart';
import 'package:flutterblochttp/ui/pages/product_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("محصولات"),
              ),
              body: Container(
                child: BlocListener<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is ProductErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitialState) {
                        return buildLoading();
                      } else if (state is ProductLoadedState) {
                        return buildProductList(state.productsList);
                      } else if (state is ProductErrorState) {
                        return buildErrorUi(state.message);
                      } else  {
                        return buildLoading();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: checkImage(products[pos].imageUrl)
              ),
              title: Text(products[pos].productName),
              subtitle: Text(products[pos]. description),
            ),
            onTap: () {
              navigateToProductDetailPage(context, products[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToProductDetailPage(BuildContext context, Product products) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDetailPage(products);
    }));
  }

  Widget checkImage(String url) {
    try {
      return Image.network(url, height: 70.0, width: 70.0, fit: BoxFit.cover);
    } catch (e) {
      return Container(
        width: 70.0,
        height: 70.0,
        child: Center(
          child: Icon(Icons.image),
        ),
      );
    }
  }
}


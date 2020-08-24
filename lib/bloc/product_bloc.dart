import 'package:bloc/bloc.dart';
import 'package:flutterblochttp/bloc/product_event.dart';
import 'package:flutterblochttp/bloc/product_state.dart';
import 'package:flutterblochttp/data/model/api_result_model.dart';
import 'package:flutterblochttp/data/repository/product_repository.dart';
import 'package:meta/meta.dart';
import '../data/model/api_result_model.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;

  ProductBloc({@required this.repository});

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();
      try {
        List<Product> products = await repository.getProducts();
        yield ProductLoadedState(productsList: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}

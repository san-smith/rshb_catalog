import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';
import 'package:rshb_catalog/domain/repository/farmer_repository.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CategoryRepository _categoryRepository;
  final FarmerRepository _farmerRepository;
  final ProductRepository _productRepository;

  CatalogBloc(
    this._categoryRepository,
    this._farmerRepository,
    this._productRepository,
  );

  List<Category> _categories = [];
  List<Farmer> _farmers = [];
  List<Product> _products = [];

  @override
  CatalogState get initialState => CatalogInitialState();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CatalogInitEvent) {
      yield* _mapCatalogInitEventToState();
    } else if (event is CatalogChangeFavoriteEvent) {
      yield* _mapCatalogChangeFavoriteEventToState(event);
    }
  }

  Stream<CatalogState> _mapCatalogInitEventToState() async* {
    yield CatalogLoadingState();
    try {
      final data = await Future.wait([
        _categoryRepository.getCategories(),
        _farmerRepository.getFarmers(),
        _productRepository.getProducts(),
      ]);
      _categories = data[0];
      _farmers = data[1];
      _products = data[2];

      yield CatalogReadyState(
        categories: _categories,
        farmers: _farmers,
        products: _products,
      );
    } catch (e) {
      yield CatalogErrorState(e.toString());
    }
  }

  Stream<CatalogState> _mapCatalogChangeFavoriteEventToState(
      CatalogChangeFavoriteEvent event) async* {
    final index = _products.indexWhere((it) => it.id == event.productId);
    _products[index] =
        _products[index].copyWith(favorite: !_products[index].favorite);
    yield CatalogReadyState(
      categories: _categories,
      farmers: _farmers,
      products: _products,
    );
  }
}

// states

abstract class CatalogState {}

class CatalogInitialState extends CatalogState {}

class CatalogLoadingState extends CatalogState {}

class CatalogReadyState extends CatalogState {
  final List<Category> categories;
  final List<Farmer> farmers;
  final List<Product> products;

  CatalogReadyState({
    @required this.categories,
    @required this.farmers,
    @required this.products,
  });
}

class CatalogErrorState extends CatalogState {
  final String message;

  CatalogErrorState(this.message);
}

// events

abstract class CatalogEvent {}

class CatalogInitEvent extends CatalogEvent {}

class CatalogChangeFavoriteEvent extends CatalogEvent {
  final int productId;

  CatalogChangeFavoriteEvent(this.productId);
}

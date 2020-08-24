import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ProductRepository _productRepository;

  CatalogBloc(
    this._productRepository,
  );

  List<Product> _products = [];
  bool _sortByPrice = false;

  @override
  CatalogState get initialState => CatalogInitialState();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CatalogInitEvent) {
      yield* _mapCatalogInitEventToState();
    } else if (event is CatalogChangeFavoriteEvent) {
      yield* _mapCatalogChangeFavoriteEventToState(event);
    } else if (event is CatalogSortEvent) {
      yield* _mapCatalogSortEventToState();
    }
  }

  Stream<CatalogState> _mapCatalogInitEventToState() async* {
    yield CatalogLoadingState();
    try {
      final data = await _productRepository.getProducts();
      _products = data;
      _sortProductsByRating();
      yield CatalogReadyState(
        products: _products,
        sortByPrice: _sortByPrice,
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
      products: _products,
      sortByPrice: _sortByPrice,
    );
  }

  Stream<CatalogState> _mapCatalogSortEventToState() async* {
    _sortByPrice = !_sortByPrice;
    if (_sortByPrice) {
      _sortProductByPrice();
    } else {
      _sortProductsByRating();
    }
    yield CatalogReadyState(
      products: _products,
      sortByPrice: _sortByPrice,
    );
  }

  void _sortProductsByRating() {
    _products.sort((a, b) => -a.totalRating.compareTo(b.totalRating));
  }

  void _sortProductByPrice() {
    _products.sort((a, b) => a.price.compareTo(b.price));
  }
}

// states

abstract class CatalogState {}

class CatalogInitialState extends CatalogState {}

class CatalogLoadingState extends CatalogState {}

class CatalogReadyState extends CatalogState {
  final List<Product> products;
  final bool sortByPrice;

  CatalogReadyState({
    @required this.products,
    @required this.sortByPrice,
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

class CatalogSortEvent extends CatalogEvent {}

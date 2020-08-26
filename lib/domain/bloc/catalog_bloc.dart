import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:rshb_catalog/domain/bloc/category_bloc.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ProductRepository _productRepository;
  final CategoryBloc categoryBloc;

  CatalogBloc(
    this._productRepository,
    this.categoryBloc,
  ) {
    categoryBloc.listen((state) {
      if (state is CategoryChangedState) {
        this.add(CatalogFilterEvent(state.category));
      }
    });
  }

  List<Product> _products = [];
  bool _sortByPrice = false;
  Category _currentCategory;

  @override
  CatalogState get initialState => CatalogInitialState();

  @override
  Future<void> close() {
    categoryBloc.close();
    return super.close();
  }

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CatalogInitEvent) {
      yield* _mapCatalogInitEventToState();
    } else if (event is CatalogChangeFavoriteEvent) {
      yield* _mapCatalogChangeFavoriteEventToState(event);
    } else if (event is CatalogSortEvent) {
      yield* _mapCatalogSortEventToState();
    } else if (event is CatalogFilterEvent) {
      yield* _mapCatalogFilterEventToState(event);
    }
  }

  Stream<CatalogState> _mapCatalogInitEventToState() async* {
    yield CatalogLoadingState();
    try {
      final data = await _productRepository.getProducts();
      _products = data;
      _sortProductsByRating();
      yield* _getCatalogReadyState();
    } catch (e) {
      yield CatalogErrorState(e.toString());
    }
  }

  Stream<CatalogState> _mapCatalogChangeFavoriteEventToState(
      CatalogChangeFavoriteEvent event) async* {
    final index = _products.indexWhere((it) => it.id == event.productId);
    _products[index] =
        _products[index].copyWith(favorite: !_products[index].favorite);
    await _productRepository.productChangeFavorite(event.productId);
    yield* _getCatalogReadyState();
  }

  Stream<CatalogState> _mapCatalogSortEventToState() async* {
    _sortByPrice = !_sortByPrice;
    if (_sortByPrice) {
      _sortProductByPrice();
    } else {
      _sortProductsByRating();
    }
    yield* _getCatalogReadyState();
  }

  Stream<CatalogState> _mapCatalogFilterEventToState(
      CatalogFilterEvent event) async* {
    _currentCategory = event.category;
    yield* _getCatalogReadyState();
  }

  Stream<CatalogState> _getCatalogReadyState() async* {
    if (_currentCategory == null) {
      yield CatalogReadyState(
        products: _products,
        sortByPrice: _sortByPrice,
      );
    } else {
      final products = _products
          .where((it) => it.categoryId == _currentCategory.id)
          .toList();
      yield CatalogReadyState(
        products: products,
        sortByPrice: _sortByPrice,
      );
    }
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

class CatalogFilterEvent extends CatalogEvent {
  final Category category;

  CatalogFilterEvent(this.category);
}

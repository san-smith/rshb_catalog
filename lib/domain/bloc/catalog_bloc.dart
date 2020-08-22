import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';
import 'package:rshb_catalog/domain/model/section.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';
import 'package:rshb_catalog/domain/repository/farmer_repository.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';
import 'package:rshb_catalog/domain/repository/section_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CategoryRepository _categoryRepository;
  final FarmerRepository _farmerRepository;
  final ProductRepository _productRepository;
  final SectionRepository _sectionRepository;

  CatalogBloc(
    this._categoryRepository,
    this._farmerRepository,
    this._productRepository,
    this._sectionRepository,
  );

  List<Category> _categories = [];
  List<Farmer> _farmers = [];
  List<Product> _products = [];
  List<Section> _sections = [];

  @override
  CatalogState get initialState => CatalogInitialState();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CatalogInitEvent) {
      yield* _mapCatalogInitEventToState();
    }
  }

  Stream<CatalogState> _mapCatalogInitEventToState() async* {
    yield CatalogLoadingState();
    try {
      final data = await Future.wait([
        _categoryRepository.getCategories(),
        _farmerRepository.getFarmers(),
        _productRepository.getProducts(),
        _sectionRepository.getSections(),
      ]);
      _categories = data[0];
      _farmers = data[1];
      _products = data[2];
      _sections = data[3];

      yield CatalogReadyState(
        categories: _categories,
        farmers: _farmers,
        products: _products,
        sections: _sections,
      );
    } catch (e) {
      yield CatalogErrorState(e.toString());
    }
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
  final List<Section> sections;

  CatalogReadyState({
    @required this.categories,
    @required this.farmers,
    @required this.products,
    @required this.sections,
  });
}

class CatalogErrorState extends CatalogState {
  final String message;

  CatalogErrorState(this.message);
}

// events

abstract class CatalogEvent {}

class CatalogInitEvent extends CatalogEvent {}

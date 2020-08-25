import 'package:rshb_catalog/domain/bloc/catalog_bloc.dart';
import 'package:rshb_catalog/domain/bloc/category_bloc.dart';
import 'package:rshb_catalog/internal/dependencies/repository_module.dart';

class CatalogModule {
  static CatalogBloc catalogBloc() {
    return CatalogBloc(
      RepositoryModule.productRepository(),
      categoryBloc(),
    );
  }

  static CategoryBloc categoryBloc() {
    return CategoryBloc(
      RepositoryModule.categoryRepository(),
    );
  }
}

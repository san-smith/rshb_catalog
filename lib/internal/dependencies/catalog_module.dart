import 'package:rshb_catalog/domain/bloc/catalog_bloc.dart';
import 'package:rshb_catalog/internal/dependencies/repository_module.dart';

class CatalogModule {
  static CatalogBloc catalogBloc() {
    return CatalogBloc(
      RepositoryModule.categoryRepository(),
      RepositoryModule.farmerRepository(),
      RepositoryModule.productRepository(),
    );
  }
}

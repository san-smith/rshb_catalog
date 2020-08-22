import 'package:rshb_catalog/data/repository/product_data_repository.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';
import 'package:rshb_catalog/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ProductRepository _productRepository;

  static ProductRepository productRepository() {
    if (_productRepository == null) {
      _productRepository = ProductDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _productRepository;
  }
}

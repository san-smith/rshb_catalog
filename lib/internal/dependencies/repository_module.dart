import 'package:rshb_catalog/data/repository/category_data_repository.dart';
import 'package:rshb_catalog/data/repository/farmer_data_repository.dart';
import 'package:rshb_catalog/data/repository/product_data_repository.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';
import 'package:rshb_catalog/domain/repository/farmer_repository.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';
import 'package:rshb_catalog/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ProductRepository _productRepository;
  static FarmerRepository _farmerRepository;
  static CategoryRepository _categoryRepository;

  static ProductRepository productRepository() {
    if (_productRepository == null) {
      _productRepository = ProductDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _productRepository;
  }


  static FarmerRepository farmerRepository() {
    if (_farmerRepository == null) {
      _farmerRepository = FarmerDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _farmerRepository;
  }

  static CategoryRepository categoryRepository() {
    if (_categoryRepository == null) {
      _categoryRepository = CategoryDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _categoryRepository;
  }
}

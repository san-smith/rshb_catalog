import 'package:rshb_catalog/data/repository/category_data_repository.dart';
import 'package:rshb_catalog/data/repository/farmer_data_repository.dart';
import 'package:rshb_catalog/data/repository/product_data_repository.dart';
import 'package:rshb_catalog/data/repository/section_data_repository.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';
import 'package:rshb_catalog/domain/repository/farmer_repository.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';
import 'package:rshb_catalog/domain/repository/section_repository.dart';
import 'package:rshb_catalog/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ProductRepository _productRepository;
  static SectionRepository _sectionRepository;
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

  static SectionRepository sectionRepository() {
    if (_sectionRepository == null) {
      _sectionRepository = SectionDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _sectionRepository;
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

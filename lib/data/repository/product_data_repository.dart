import 'package:rshb_catalog/data/api/api_util.dart';
import 'package:rshb_catalog/domain/repository/product_repository.dart';

class ProductDataRepository extends ProductRepository {
  final ApiUtil _apiUtil;

  ProductDataRepository(this._apiUtil);
}

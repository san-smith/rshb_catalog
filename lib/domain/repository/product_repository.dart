import 'package:rshb_catalog/domain/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

import 'package:rshb_catalog/data/api/fake_server.dart';
import 'package:rshb_catalog/data/api/mapper/category_mapper.dart';
import 'package:rshb_catalog/data/api/mapper/farmer_mapper.dart';
import 'package:rshb_catalog/data/api/mapper/product_mapper.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';

class ApiUtil {
  final FakeServer _server;
  ApiUtil(this._server);

  Future<List<Category>> getCategories() async {
    final result = await _server.getCategories();
    return result
        .map((it) => CategoryMapper.fromApi(it))
        .toList(growable: false);
  }

  Future<List<Farmer>> getFarmers() async {
    final result = await _server.getFarmers();
    return result.map((it) => FarmerMapper.fromApi(it)).toList(growable: false);
  }

  Future<List<Product>> getProducts() async {
    final result = await _server.getProducts();
    return result
        .map((it) => ProductMapper.fromApi(it))
        .toList(growable: false);
  }

  Future<void> productChangeFavorite(int id) async {
    return _server.productChangeFavorite(id);
  }
}

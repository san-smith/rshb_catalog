import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rshb_catalog/data/api/mapper/category_mapper.dart';
import 'package:rshb_catalog/data/api/mapper/farmer_mapper.dart';
import 'package:rshb_catalog/data/api/mapper/product_mapper.dart';
import 'package:rshb_catalog/data/api/model/api_category.dart';
import 'package:rshb_catalog/data/api/model/api_farmer.dart';
import 'package:rshb_catalog/data/api/model/api_product.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/model/product.dart';

class ApiUtil {
  ApiUtil() {
    _loadFixture();
  }

  static Map<String, dynamic> _fixture;

  Future<void> _loadFixture() async {
    final data = await rootBundle.loadString('assets/fixture.json');
    _fixture = json.decode(data);
  }

  Future<List<Category>> getCategories() async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['categories'])
          .map((it) => ApiCategory.fromMap(it))
          .map((it) => CategoryMapper.fromApi(it))
          .toList(growable: false);
    });
  }

  Future<List<Farmer>> getFarmers() async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['farmers'])
          .map((it) => ApiFarmer.fromMap(it))
          .map((it) => FarmerMapper.fromApi(it))
          .toList(growable: false);
    });
  }

  Future<List<Product>> getProducts() async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['products'])
          .map((it) => ApiProduct.fromMap(it))
          .map((it) => ProductMapper.fromApi(it))
          .toList(growable: false);
    });
  }
}

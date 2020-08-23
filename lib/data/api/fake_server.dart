import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rshb_catalog/data/api/model/api_category.dart';
import 'package:rshb_catalog/data/api/model/api_product.dart';

import 'model/api_farmer.dart';

class FakeServer {
  FakeServer() {
    _loadFixture();
  }

  static Map<String, dynamic> _fixture;

  Future<void> _loadFixture() async {
    final data = await rootBundle.loadString('assets/fixture.json');
    _fixture = json.decode(data);
    List<dynamic> farmers = _fixture['farmers'];
    List.of(_fixture['products']).forEach((it) {
      final farmer = farmers.firstWhere(
        (f) => f['id'] == it['farmerId'],
        orElse: () => null,
      );
      it['farmer'] = farmer;
    });
  }

  Future<List<ApiCategory>> getCategories() {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['categories'])
          .map((it) => ApiCategory.fromMap(it))
          .toList(growable: false);
    });
  }

  Future<List<ApiFarmer>> getFarmers() {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['farmers'])
          .map((it) => ApiFarmer.fromMap(it))
          .toList(growable: false);
    });
  }

  Future<List<ApiProduct>> getProducts() {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['products'])
          .map((it) => ApiProduct.fromMap(it))
          .toList(growable: false);
    });
  }
}

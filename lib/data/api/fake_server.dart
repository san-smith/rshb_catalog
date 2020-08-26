import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:rshb_catalog/data/api/model/api_category.dart';
import 'package:rshb_catalog/data/api/model/api_product.dart';

import 'model/api_farmer.dart';

class FakeServer {
  FakeServer() {
    _loadFixture();
  }

  static Map<String, dynamic> _fixture;

  Future<void> _loadFixture() async {
    String data = await _readDataFromFixture();
    if (data == null) {
      data = await rootBundle.loadString('assets/fixture.json');
      _fixture = json.decode(data);
      _writeDataToFile();
    }

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

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getLocalFile() async {
    final path = await _getLocalPath();
    return File('$path/fixture.json');
  }

  Future<String> _readDataFromFixture() async {
    try {
      final file = await _getLocalFile();
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<File> _writeDataToFile() async {
    final file = await _getLocalFile();
    return file.writeAsString(json.encode(_fixture));
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

  Future<void> productChangeFavorite(int id) async {
    final product =
        List.of(_fixture['products']).firstWhere((it) => it['id'] == id);
    product['favorite'] = !product['favorite'];
    await _writeDataToFile();
  }
}

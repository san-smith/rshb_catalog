import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rshb_catalog/data/api/mapper/section_mapper.dart';
import 'package:rshb_catalog/data/api/model/api_section.dart';
import 'package:rshb_catalog/domain/model/section.dart';

class ApiUtil {
  ApiUtil() {
    _loadFixture();
  }

  static Map<String, dynamic> _fixture;

  Future<void> _loadFixture() async {
    final data = await rootBundle.loadString('assets/fixture.json');
    _fixture = json.decode(data);
  }

  Future<List<Section>> getSections() async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return List.of(_fixture['sections'])
          .map((it) => ApiSection.fromMap(it))
          .map((it) => SectionMapper.fromApi(it))
          .toList(growable: false);
    });
  }
}

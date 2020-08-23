import 'package:rshb_catalog/data/api/model/api_farmer.dart';

import 'api_product_characteristic.dart';

class ApiProduct {
  final int id;
  final int sectionId;
  final int categoryId;
  final String title;
  final String unit;
  final num totalRating;
  final int ratingCount;
  final String image;
  final String shortDescription;
  final String description;
  final num price;
  final bool favorite;
  final ApiFarmer farmer;
  final List<ApiProductCharacteristic> characteristics;

  ApiProduct.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        sectionId = map['sectionId'],
        categoryId = map['categoryId'],
        title = map['title'],
        unit = map['unit'],
        totalRating = map['totalRating'],
        ratingCount = map['ratingCount'],
        image = map['image'],
        shortDescription = map['shortDescription'],
        description = map['description'],
        price = map['price'],
        favorite = map['favorite'] ?? false,
        farmer = ApiFarmer.fromMap(map['farmer']),
        characteristics = List.of(map['characteristics'])
            .map((it) => ApiProductCharacteristic.fromMap(it))
            .toList(growable: false);
}

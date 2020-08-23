import 'package:meta/meta.dart';

import 'product_characteristic.dart';

class Product {
  final int id;
  final int sectionId;
  final int categoryId;
  final int farmerId;
  final String title;
  final String unit;
  final double totalRating;
  final int ratingCount;
  final String image;
  final String shortDescription;
  final String description;
  final double price;
  final bool favorite;
  final List<ProductCharacteristic> characteristics;

  Product({
    @required this.id,
    @required this.sectionId,
    @required this.categoryId,
    @required this.farmerId,
    @required this.title,
    @required this.unit,
    @required this.totalRating,
    @required this.ratingCount,
    @required this.image,
    @required this.shortDescription,
    @required this.description,
    @required this.price,
    @required this.favorite,
    @required this.characteristics,
  });

  Product copyWith({bool favorite}) {
    return Product(
      id: id,
      sectionId: sectionId,
      categoryId: categoryId,
      farmerId: farmerId,
      title: title,
      unit: unit,
      totalRating: totalRating,
      ratingCount: ratingCount,
      image: image,
      shortDescription: shortDescription,
      description: description,
      price: price,
      favorite: favorite,
      characteristics: characteristics,
    );
  }
}

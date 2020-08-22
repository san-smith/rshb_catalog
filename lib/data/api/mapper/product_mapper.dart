import 'package:rshb_catalog/data/api/mapper/product_characteristic_mapper.dart';
import 'package:rshb_catalog/data/api/model/api_product.dart';
import 'package:rshb_catalog/domain/model/product.dart';

class ProductMapper {
  static Product fromApi(ApiProduct product) {
    return Product(
      id: product.id,
      sectionId: product.sectionId,
      categoryId: product.categoryId,
      farmerId: product.farmerId,
      title: product.title,
      unit: product.unit,
      totalRating: product.totalRating.toDouble(),
      ratingCount: product.ratingCount,
      image: product.image,
      shortDescription: product.shortDescription,
      description: product.description,
      price: product.price.toDouble(),
      characteristics: product.characteristics
          .map((it) => ProductCharacteristicMapper.fromApi(it))
          .toList(growable: false),
    );
  }
}

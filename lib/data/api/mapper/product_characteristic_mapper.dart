import 'package:rshb_catalog/data/api/model/api_product_characteristic.dart';
import 'package:rshb_catalog/domain/model/product_characteristic.dart';

class ProductCharacteristicMapper {
  static ProductCharacteristic fromApi(ApiProductCharacteristic ch) {
    return ProductCharacteristic(
      title: ch.title,
      value: ch.value,
    );
  }
}

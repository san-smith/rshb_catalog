import 'package:rshb_catalog/data/api/model/api_category.dart';
import 'package:rshb_catalog/domain/model/category.dart';

class CategoryMapper {
  static Category fromApi(ApiCategory category) {
    return Category(
      id: category.id,
      sectionId: category.sectionId,
      title: category.title,
      iconUri: category.iconUri,
    );
  }
}

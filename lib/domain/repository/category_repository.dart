import 'package:rshb_catalog/domain/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}
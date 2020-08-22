import 'package:rshb_catalog/data/api/api_util.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';

class CategoryDataRepository extends CategoryRepository {
  final ApiUtil _apiUtil;

  CategoryDataRepository(this._apiUtil);

  @override
  Future<List<Category>> getCategories() {
    return _apiUtil.getCategories();
  }
}

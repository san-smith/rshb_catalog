import 'package:rshb_catalog/data/api/api_util.dart';
import 'package:rshb_catalog/domain/model/section.dart';
import 'package:rshb_catalog/domain/repository/section_repository.dart';

class SectionDataRepository extends SectionRepository {
  final ApiUtil _apiUtil;

  SectionDataRepository(this._apiUtil);
  
  @override
  Future<List<Section>> getSections() {
    return _apiUtil.getSections();
  }
}
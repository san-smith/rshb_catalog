import 'package:rshb_catalog/data/api/api_util.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';
import 'package:rshb_catalog/domain/repository/farmer_repository.dart';

class FarmerDataRepository extends FarmerRepository {
  final ApiUtil _apiUtil;

  FarmerDataRepository(this._apiUtil);

  @override
  Future<List<Farmer>> getFarmers() {
    return _apiUtil.getFarmers();
  }
}
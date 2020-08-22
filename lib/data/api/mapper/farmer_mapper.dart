import 'package:rshb_catalog/data/api/model/api_farmer.dart';
import 'package:rshb_catalog/domain/model/farmer.dart';

class FarmerMapper {
  static Farmer fromApi(ApiFarmer farmer) {
    return Farmer(
      id: farmer.id,
      title: farmer.title,
    );
  }
}

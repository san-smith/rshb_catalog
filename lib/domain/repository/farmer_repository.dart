import 'package:rshb_catalog/domain/model/farmer.dart';

abstract class FarmerRepository {
  Future<List<Farmer>> getFarmers();
}
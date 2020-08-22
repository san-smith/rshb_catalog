import 'package:rshb_catalog/domain/model/section.dart';

abstract class SectionRepository {
  Future<List<Section>> getSections();
}
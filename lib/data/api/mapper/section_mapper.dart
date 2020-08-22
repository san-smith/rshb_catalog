import 'package:rshb_catalog/data/api/model/api_section.dart';
import 'package:rshb_catalog/domain/model/section.dart';

class SectionMapper {
  static Section fromApi(ApiSection section) {
    return Section(
      id: section.id,
      title: section.title,
    );
  }
}

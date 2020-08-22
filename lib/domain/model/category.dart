import 'package:meta/meta.dart';

class Category {
  final int id;
  final int sectionId;
  final String title;
  final String iconUri;

  Category({
    @required this.id,
    @required this.sectionId,
    @required this.title,
    @required this.iconUri,
  });
}

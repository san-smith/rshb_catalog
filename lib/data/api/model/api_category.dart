class ApiCategory {
  final int id;
  final int sectionId;
  final String title;
  final String iconUri;

  ApiCategory.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        sectionId = map['sectionId'],
        title = map['title'],
        iconUri = map['iconUri'];
}

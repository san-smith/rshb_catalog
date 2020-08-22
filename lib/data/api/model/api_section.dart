class ApiSection {
  final int id;
  final String title;

  ApiSection.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'];
}

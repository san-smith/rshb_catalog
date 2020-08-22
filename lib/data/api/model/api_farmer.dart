class ApiFarmer {
  final int id;
  final String title;

  ApiFarmer.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'];
}

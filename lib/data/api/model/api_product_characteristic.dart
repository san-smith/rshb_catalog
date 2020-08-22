class ApiProductCharacteristic {
  final String title;
  final String value;

  ApiProductCharacteristic.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        value = map['title'];
}

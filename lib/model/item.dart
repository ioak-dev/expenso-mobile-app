class Item {
  final int? id;
  final String appName;
  final String connectionName;
  final String apiKey;

  Item({this.id, required this.appName, required this.connectionName, required this.apiKey });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appName': appName,
      'connectionName': connectionName,
      'apiKey':apiKey
    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      appName: map['appName'],
      connectionName: map['connectionName'],
      apiKey:map['apiKey'],
    );
  }
}

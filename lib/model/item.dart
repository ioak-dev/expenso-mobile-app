class Item {
  final int? id;
  final String appName;
  final String connectionName;
  final String apiKey;
  final String displayName;
  final String description;
  final String logoDark;
  final String logoLight;

  Item({this.id, required this.appName, required this.connectionName, required this.apiKey, required this.displayName, required this.description, required this.logoDark,  required this.logoLight, });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appName': appName,
      'connectionName': connectionName,
      'apiKey':apiKey,
      'displayName':displayName,
      'description':description,
      'logoDark':logoDark,
      'logoLight':logoLight

    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      appName: map['appName'],
      connectionName: map['connectionName'],
      apiKey:map['apiKey'],
      displayName: map['displayName'],
      description: map['description'],
      logoDark: map['logoDark'],
      logoLight: map['logoLight'],
    );
  }
}

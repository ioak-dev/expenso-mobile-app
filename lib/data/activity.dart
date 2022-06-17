class Activity {
  final int id;
  final String name;
  final int seconds;
  final int order;

  const Activity({
    required this.id,
    required this.name,
    required this.seconds,
    required this.order,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'seconds': seconds,
      'order': order,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, seconds: $seconds, order: $order}';
  }
}
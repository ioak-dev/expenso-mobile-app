import 'package:flutter/material.dart';
import 'screens/item_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ItemListScreen(),
    );
  }
}

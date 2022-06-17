import 'package:endurance/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnduranceApp());
}

class EnduranceApp extends StatelessWidget {
  const EnduranceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endurance',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        primaryColor: Colors.blue
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(title: 'Home Page'),
    );
  }
}

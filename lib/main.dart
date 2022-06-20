import 'package:endurance/preset/preset_create/preset_create_page.dart';
import 'package:endurance/dashboard/dashboard_page.dart';
import 'package:endurance/home/home_page.dart';
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
        primaryColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Home Page'),
        '/preset/create': (context) => const CreatePresetPage()
      },
    );
  }
}

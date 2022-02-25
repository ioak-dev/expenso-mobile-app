import 'package:expenso_mobile_app/pages/home_page.dart';
import 'package:expenso_mobile_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        "/" :(context) => HomePage(),
        "/home" :(context) => HomePage(),
        "/login" :(context) => LoginPage()
      },
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // var url = Uri.http("https://reqres.in", "/api/users");
    // var response = http.get(url).then((value) => )
    // var jsonResponse = convert.jsonDecode(response.body);
    return Container();
  }
}

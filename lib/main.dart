import 'package:flutter/material.dart';

void main() {
  runApp(PulseApp());
}

class PulseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: CreateConnection(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Text(
          "Welcome to the Home Screen!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}


class CreateConnection extends StatefulWidget {
  @override
  _CreateConnectionScreenState createState() => _CreateConnectionScreenState();
}

class _CreateConnectionScreenState extends State<CreateConnection> {

  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _connectionNameController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();

  void _handleCreateConnection() {
    String appName = _appNameController.text;
    String connectionName = _connectionNameController.text;
    String apiKey = _apiKeyController.text;

    // Example: Simple validation
    if (appName.isNotEmpty && connectionName.isNotEmpty && apiKey.isNotEmpty) {
      print("Values: $appName, $connectionName, $apiKey");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome!")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create Connection",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),

            TextField(
              controller: _appNameController,
              decoration: InputDecoration(
                labelText: "App name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),

            TextField(
              controller: _connectionNameController,
              decoration: InputDecoration(
                labelText: "Connection name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: TextField(
            //     controller: _connectionNameController,
            //     decoration: InputDecoration(
            //       labelText: "Connection name",
            //       border: OutlineInputBorder(),
            //     ),
            //   ),
            // ),

            TextField(
              controller: _apiKeyController,
              decoration: InputDecoration(
                labelText: "Api key",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),


            Center(
              child: ElevatedButton(
                onPressed: _handleCreateConnection,
                child: Text("Create"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(150, 50),
                ),
                // style: ElevatedButton.styleFrom(
                //   minimumSize: Size(double.infinity, 50),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

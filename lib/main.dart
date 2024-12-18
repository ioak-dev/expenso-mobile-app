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
  void _openConnection(BuildContext context) {
    print("Open connection");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DescriptionScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connections"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connections',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        const Text(
                          'Connection name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        const Text(
                          'Subtitle.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => _openConnection(context),
                            child: Text('Open'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  const Positioned(
                    top: -20,
                    left: 20,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black26,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    top: 10,
                    right: 0,
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      onSelected: (value) {
                        print('Selected: $value');
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Option 1',
                          child: Text('Option 1'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Option 2',
                          child: Text('Option 2'),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text(
          'Connection name',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 40),
      Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Form Name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15), // Space between title and subtitle
                            Text(
                              'Subtitle describing the form',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 0,
                right: 5,
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  onSelected: (value) {
                    print('Selected: $value');
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                  ],
                ),
              ),

              const Positioned(
                bottom: 5,
                right: 15,
                child: Icon(
                  Icons.arrow_forward,
                  size: 28,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        ],
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

    if (appName.isNotEmpty && connectionName.isNotEmpty && apiKey.isNotEmpty) {
      print("Values: $appName, $connectionName, $apiKey");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/item.dart';
import 'db_helper.dart';

void main() {
  runApp(const PulseApp());
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: const CreateConnection(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  late String appName;
  late String connectionName;

  HomeScreen({
    super.key,
    // required this.appName,
    // required this.connectionName,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> items = [];
  var _selectedIndex=0;

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  Future<void> refreshItems() async {
    final data = await DBHelper.instance.fetchAllItems();
    setState(() {
      items = data;
    });
  }

  void _openConnection(BuildContext context, String connectionName, String appName, int connectionId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescriptionScreen(
          appName: appName,
          connectionName: connectionName,
          connectionId: connectionId
        ),
      ),
    );
  }

  void _handleCreateConnection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateConnection()),
    ).then((_) => refreshItems()); // Refresh after navigating back
  }

  void _deleteConnection(int id) async {
    await DBHelper.instance.deleteItem(id);
    refreshItems();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connections"),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 24.0,
              color: Colors.black,
            ),
            onSelected: (value) {
              if (value == 'createConnection') {
                _handleCreateConnection(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'createConnection',
                child: Text('Create connection'),
              ),
            ],
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('No connections found.'))
          : ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 25.0),
        itemBuilder: (context, index) {
          final item = items[index];
          final connectionName = item['connectionName'] ?? '';
          final appName = item['appName'] ?? '';
          final connectionId = item['id'] ?? '';

          return Card(
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
                      const SizedBox(height: 20),
                      Text(
                        connectionName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        appName,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),


                Positioned(
                  top: -20,
                  left: 20,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black26,
                    child: Text(
                      connectionName.isNotEmpty
                          ? connectionName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
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
                      if (value == 'delete') {
                        print('Delete selected for $connectionName');
                        _deleteConnection(item['id']);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () => _openConnection(context, connectionName, appName, connectionId),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Open'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        elevation:10,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DescriptionScreen extends StatefulWidget {
  final String appName;
  final String connectionName;
  final int connectionId;

  const DescriptionScreen({
    super.key,
    required this.appName,
    required this.connectionName,
    required this.connectionId,
  });

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  List<Map<String, dynamic>> items = [];
  var _selectedIndex=0;

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  Future<void> refreshItems() async {
    final data = await DBHelper.instance.fetchAllItems();
    setState(() {
      items = data;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.connectionName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Text(
                                widget.connectionName.isNotEmpty
                                    ? widget.connectionName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.connectionName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15), // Space between title and subtitle
                                Text(
                                  widget.appName,
                                  style: const TextStyle(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        elevation:10,
        onTap: _onItemTapped,
      ),
    );
  }
}




class CreateConnection extends StatefulWidget {
  final Item? item;
  const CreateConnection({super.key, this.item});

  @override
  _CreateConnectionScreenState createState() => _CreateConnectionScreenState();
}

class _CreateConnectionScreenState extends State<CreateConnection> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _connectionNameController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  var _selectedAppName;
  var _selectedIndex=0;

  void _handleCreateConnection() async {
    try {
      String appName = _selectedAppName;
      String connectionName = _connectionNameController.text;
      String apiKey = _apiKeyController.text;

      if (_formKey.currentState!.validate()) {
        final item = Item(
          id: widget.item?.id,
          appName: appName,
          connectionName: connectionName,
          apiKey: apiKey,
        );

        if (widget.item == null) {
          await DBHelper.instance.insertItem(item.toMap());
        } else {
          await DBHelper.instance.updateItem(item.toMap(), widget.item!.id!);
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(
            // appName: appName,
            // connectionName: connectionName,
          ),),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter all fields')),
        );
      }
    } catch (e) {
      print("Error in _handleCreateConnection: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    length: 3;
    return Scaffold(
      appBar: AppBar(title: const Text("Create Connection"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
        child: Form(
          key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedAppName,
              decoration: const InputDecoration(
                labelText: "App name",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "App1",
                  child: Text("App1"),
                ),
                DropdownMenuItem(
                  value: "App2",
                  child: Text("App2"),
                ),
                DropdownMenuItem(
                  value: "App3",
                  child: Text("App3"),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAppName = newValue!;
                });
              },
            ),
            const SizedBox(height: 50),

            TextField(
              controller: _connectionNameController,
              decoration: const InputDecoration(
                labelText: "Connection name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),

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
              decoration: const InputDecoration(
                labelText: "Api key",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),


            // Center(
            //   child: ElevatedButton(
            //     onPressed: _handleCreateConnection,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.black,
            //       foregroundColor: Colors.white,
            //       minimumSize: const Size(150, 50),
            //     ),
            //     child: const Text("Create"),
            //   ),
            // ),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreateConnection,
        child: const Icon(Icons.check),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        elevation:10,
        onTap: _onItemTapped,
      ),
    );
  }
}

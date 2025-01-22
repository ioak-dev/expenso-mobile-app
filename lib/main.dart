import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/item.dart';
import 'db_helper.dart';
import 'network_helper.dart';

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

  void _openConnection(BuildContext context, String connectionName, String appName, int connectionId, String logoDark) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescriptionScreen(
          appName: appName,
          connectionName: connectionName,
          connectionId: connectionId,
            logoDark:logoDark
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
          final displayName = item['displayName'] ?? '';
          final description = item['description'] ?? '';
          final logoDark = item['logoDark'] ?? '';
          final logoLight = item['logoLight'] ?? '';

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
                      const SizedBox(height: 8),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
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
                    backgroundColor: Colors.red,
                    child: ClipOval(
                        child: SvgPicture.network(
                          logoDark,
                          width: 114,
                          height: 114,
                            placeholderBuilder: (context) => Container(
                              width: 114,
                              height: 114,
                              color: Colors.red[50],
                              child: const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 50,
                              ), // Custom error icon
                            )
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
                      } else if(value =='edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateConnection(
                              item: Item(
                                id: item['id'],
                                appName: item['appName'],
                                connectionName: item['connectionName'],
                                apiKey: item['apiKey'],
                                displayName: item['displayName'],
                                description: item['description'],
                                logoDark: item['logoDark'],
                                logoLight: item['logoLight'],
                              ),
                            ),
                          ),
                        ).then((_) => refreshItems());
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () => _openConnection(context, connectionName, appName, connectionId, logoDark),
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
  final String logoDark;

  const DescriptionScreen({
    super.key,
    required this.appName,
    required this.connectionName,
    required this.connectionId,
    required this.logoDark
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
                              backgroundColor: Colors.red,
                              child: ClipOval(
                                child: SvgPicture.network(
                                    widget.logoDark,
                                    width: 114,
                                    height: 114,
                                    placeholderBuilder: (context) => Container(
                                      width: 114,
                                      height: 114,
                                      color: Colors.red[50],
                                      child: const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 50,
                                      ), // Custom error icon
                                    )
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
  final NetworkHelper _networkHelper = NetworkHelper('https://api.ioak.io:8100/api/portal');
  Map<String, dynamic> _item = {};
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _selectedAppName = widget.item!.appName;
      _connectionNameController.text = widget.item!.connectionName;
      _apiKeyController.text = widget.item!.apiKey;
    }
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   print("fetching data");
  //   var token='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjUzNjAzMjI3ODMzYTgwMDE3NWYxZWEyIiwiZ2l2ZW5fbmFtZSI6IkphbmUiLCJmYW1pbHlfbmFtZSI6IkRvZSIsIm5hbWUiOiJKYW5lIERvZSIsIm5pY2tuYW1lIjoiSmFuZSIsImVtYWlsIjoiamFuZS5kb2VAaW9hay5vcmciLCJ0eXBlIjoib25lYXV0aCIsInBlcm1pc3Npb25zIjp7IkNPTVBBTllfQURNSU4iOlsiMSIsIjIiLCIzIiwiNCIsIjUiLCI2IiwiNyJdfSwiaWF0IjoxNzM3MDI0MzQzLCJleHAiOjE3MzcwMzE1NDN9.ZrEhsNYRwff3JTfXMnYGYfkDNCKr1wM0-fl6ovkkyhWxmDLpgyPBb0X-YavIv4jRF-xWJtMClirnE4jnaQe06OxILCN2UvbjRqXpE0iNMYAtZbGNDEpCllIEgUSSnU6OIZ0jhUxL6AdpF48zVistoK7l8krfAQBl29TyDmk5xebRLCvhQfdzb6U_bnda9viO6IU86Hw8jHDeVLZLW7D58uGQ2VMkN7ArCP97T17A5c4Qm1ciWxKIMZHpliLPDNin2-rqHIjmVwOftaFmgCcoRBElIjHGz3MDntwcRMzd8pJ73euR2PYMfKCOfllnf48JREJ-16bNk5Eo1FRC6odsvqlngjevAtHdbvSTwrEw3-6rHwLL-br1nY64XPl9bxU6xN1yNhM_EVfsso-Tk7Hu8GHl8oJ0UcJppvaKATTXAEKURkn_6tycDdOWg3Eui65AgJsLTq6FskrLVgnmSyQjX-n8DR5FlcOAW8UzuTgTItPYUmCg27LB7eY-rSGmBgSmpVBn1Cr8CGaRpzhCyzQL9_VAsiIctuMNCGVKolIeoO2VsZIIdU6gLKsCXGt0X4r68CP8blS1VwWf9ehSysv0w8A3WkGxwSE1RJh-h52K0Gr_F6CoKB3JhIUBJQPxtTUL3zbyUdimBpFyyGQudyBVmzx7dkGPcGrkichICd20VAs';
  //   var displayName='demo3';
  //   var space=1;
  //   try {
  //     final response = await _networkHelper.get('/token/$space/$displayName',token);
  //     print('response $response');
  //     if (response.outcome) {
  //       setState(() {
  //         _item = response;
  //       });
  //     }
  //     print("item $_item");
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }


  Future<Map<String, dynamic>?>  createConnectionService(String apiKey) async {
    try {
      final response = await _networkHelper.get('/schema', apiKey);
      print('Response: $response');
      return response;
      if (response['authorization']) {
        return response;
      } else {
        print('Authorization failed');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  void _handleCreateConnection() async {
    try {
      String appName = _selectedAppName;
      String connectionName = _connectionNameController.text;
      String apiKey = _apiKeyController.text;

      if (_formKey.currentState!.validate()) {
        final response = await createConnectionService(apiKey);
        // final Map<String, dynamic> data = json.decode(response);
        print('second api $response');
        if (response != null) {

          final item = Item(
            id: widget.item?.id,
            appName: appName,
            connectionName: connectionName,
            apiKey: apiKey,
            displayName:response['displayName'],
            description:response['description'],
            logoDark:response['logo']['dark'],
            logoLight:response['logo']['light']
          );

          if (widget.item == null) {
            await DBHelper.instance.insertItem(item.toMap());
          } else {
            await DBHelper.instance.updateItem(item.toMap(), widget.item!.id!);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authorization failed or no response')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter all fields')),
        );
      }
    } catch (e) {
      print("Error in _handleCreateConnection: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
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
                DropdownMenuItem(
                  value: "Fortuna",
                  child: Text("Fortuna"),
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

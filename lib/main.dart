import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LuxonModsApp());
}

class LuxonModsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LuxonMods',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
      ),
      home: LuxonModsPage(),
    );
  }
}

class LuxonModsPage extends StatefulWidget {
  @override
  _LuxonModsPageState createState() => _LuxonModsPageState();
}

class _LuxonModsPageState extends State<LuxonModsPage> {
  final TextEditingController _keyController = TextEditingController();
  String _responseMessage = "";

  Future<void> loginWithKey() async {
    final String key = _keyController.text.trim();
    if (key.isEmpty) {
      setState(() {
        _responseMessage = "Please enter a key.";
      });
      return;
    }

    final String apiUrl = "https://your-api-endpoint.com/login"; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'key': key},
      );

      setState(() {
        if (response.statusCode == 200) {
          _responseMessage = "Login successful: ${response.body}";
        } else {
          _responseMessage = "Error: ${response.body}";
        }
      });
    } catch (e) {
      setState(() {
        _responseMessage = "Failed to connect to API: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LuxonMods',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: 'Enter your key',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginWithKey,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 28.0),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text('Log In With Key'),
              ),
              SizedBox(height: 20),
              if (_responseMessage.isNotEmpty)
                Text(
                  _responseMessage,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

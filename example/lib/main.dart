import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Prevent App Screen Example',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _preventAppScreenPlugin = PreventAppScreen();
  bool _isSecure = false;

  Future<void> _toggleScreenSecure() async {
    try {
      final bool newStatus = !_isSecure;
      if (newStatus) {
        await _preventAppScreenPlugin.enableSecure();
      } else {
        await _preventAppScreenPlugin.disableSecure();
      }
      setState(() {
        _isSecure = newStatus;
      });
    } catch (e) {
      debugPrint("Failed to toggle screen secure: '$e'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevent App Screen Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSecure ? Icons.lock : Icons.lock_open,
              size: 100,
              color: _isSecure ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isSecure ? 'ScreenShot Disabled' : 'ScreenShot Enabled',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleScreenSecure,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isSecure ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(_isSecure ? 'Disable Protection' : 'Enable Protection'),
            ),
          ],
        ),
      ),
    );
  }
}

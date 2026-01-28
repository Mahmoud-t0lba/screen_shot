import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Prevent ScreenShot',
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
  static const MethodChannel _channel = MethodChannel('prevent_screen');
  bool _isSecure = false;

  Future<void> _toggleScreenSecure() async {
    try {
      final bool newStatus = !_isSecure;
      if (newStatus) {
        await _channel.invokeMethod('enableSecure');
      } else {
        await _channel.invokeMethod('disableSecure');
      }
      setState(() {
        _isSecure = newStatus;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to toggle screen secure: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
    // _channel.invokeMethod('disableSecure');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevent ScreenShot'),
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

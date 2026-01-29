import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class FullScreenProtectionScreen extends StatefulWidget {
  const FullScreenProtectionScreen({super.key});

  @override
  State<FullScreenProtectionScreen> createState() =>
      _FullScreenProtectionScreenState();
}

class _FullScreenProtectionScreenState
    extends State<FullScreenProtectionScreen> {
  bool _secureScreen = false;

  @override
  Widget build(BuildContext context) {
    // Window-level protection for this specific screen
    return FullScreenProtection(
      prevent: _secureScreen,
      child: Scaffold(
        appBar: AppBar(title: const Text("Full Screen Protection")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fullscreen_exit, size: 100, color: Colors.blue),
              const SizedBox(height: 30),
              const Text(
                "WINDOW PROTECTED",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "This screen is wrapped with FullScreenProtection. All screenshots are blocked at the OS level.",
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("App-wide (Global) Protection"),
                subtitle: const Text("Enable protection for all screens"),
                value: _secureScreen,
                onChanged: (val) async {
                  setState(() => _secureScreen = val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class GlobalProtectionDemo extends StatefulWidget {
  const GlobalProtectionDemo({super.key});

  @override
  State<GlobalProtectionDemo> createState() => _GlobalProtectionDemoState();
}

class _GlobalTransformation {
  static bool isCurrentlySecure = false;
}

class _GlobalProtectionDemoState extends State<GlobalProtectionDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Global Protection")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _GlobalTransformation.isCurrentlySecure ? Icons.lock : Icons.lock_open,
              size: 100,
              color: _GlobalTransformation.isCurrentlySecure ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 30),
            Text(
              "Global Security: ${_GlobalTransformation.isCurrentlySecure ? 'ON' : 'OFF'}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text(
                "When enabled, the entire app is protected from screenshots and screen recording at the OS level.",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final newState = !_GlobalTransformation.isCurrentlySecure;
                await PreventAppScreen.initialize(newState);
                setState(() => _GlobalTransformation.isCurrentlySecure = newState);
              },
              icon: Icon(_GlobalTransformation.isCurrentlySecure ? Icons.security_update_good : Icons.security),
              label: Text(_GlobalTransformation.isCurrentlySecure ? "Disable Globally" : "Enable Globally"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

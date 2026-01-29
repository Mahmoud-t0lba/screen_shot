import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class WindowProtectionDemo extends StatelessWidget {
  const WindowProtectionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapping the entire screen with FullScreenProtection
    return FullScreenProtection(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Full Screen Protection"),
          backgroundColor: Colors.orange.shade100,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security, size: 100, color: Colors.orange),
                const SizedBox(height: 30),
                const Text(
                  "Screen Level Protection",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "This screen is protected by FullScreenProtection. While you are on this page, the OS will block all screenshots and recordings of the window.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                            "Try taking a screenshot now! It will be blocked or show a black/secure screen."),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

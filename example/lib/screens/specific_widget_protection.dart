import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class SpecificWidgetProtectionScreen extends StatelessWidget {
  const SpecificWidgetProtectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Specific Widget Protection")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                "🚀 To block screenshots for this specific card, we enable 'protectWindow' below. This secures the whole app while this card is visible.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(height: 30),
            SpecificWidgetProtection(
              protectWindow: true, // AUTO-TRIGGERS WINDOW SECURITY
              placeholder: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.white, size: 50),
                    SizedBox(height: 10),
                    Text("SECURE CONTENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.indigo.shade800, Colors.indigo.shade500]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SECRET KEY", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    SizedBox(height: 10),
                    Text(
                      "sk-live-52b3-99ab-6621-001x",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontFamily: 'monospace', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.vpn_key, color: Colors.white30, size: 40),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Because 'protectWindow' is true above, you cannot take a screenshot of this entire page right now!",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

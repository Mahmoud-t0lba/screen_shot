import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class SpecificWidgetProtectionScreen extends StatefulWidget {
  const SpecificWidgetProtectionScreen({super.key});

  @override
  State<SpecificWidgetProtectionScreen> createState() => _SpecificWidgetProtectionScreenState();
}

class _SpecificWidgetProtectionScreenState extends State<SpecificWidgetProtectionScreen> {
  bool _forceBlur = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Specific Widget Protection")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Only the card below is protected (blurred) when capture is detected.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SpecificWidgetProtection(
              prevent: true,
              forceBlur: _forceBlur,
              blurAmount: 18,
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
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => setState(() => _forceBlur = !_forceBlur),
              icon: Icon(_forceBlur ? Icons.visibility : Icons.visibility_off),
              label: Text(_forceBlur ? "Show Content" : "Blur Content Now"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

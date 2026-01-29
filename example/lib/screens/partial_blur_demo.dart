
import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

class PartialBlurDemo extends StatefulWidget {
  const PartialBlurDemo({super.key});

  @override
  State<PartialBlurDemo> createState() => _PartialBlurDemoState();
}

class _PartialBlurDemoState extends State<PartialBlurDemo> {
  bool _forceBlur = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Partial Blur (SecureWidget)")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "The info box below uses SpecificWidgetProtection. It will automatically blur if the screen is being recorded, or you can toggle it manually.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // This is the specific widget being protected
            SpecificWidgetProtection(
              prevent: true,
              forceBlur: _forceBlur,
              blurAmount: 15,
              child: Card(
                elevation: 8,
                color: Colors.purple.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(Icons.credit_card, size: 60, color: Colors.purple),
                      SizedBox(height: 15),
                      Text(
                        "PRIVATE ACCOUNT INFO",
                        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                      Divider(height: 30),
                      Text(
                        "4532 - 1289 - 0034 - 1234",
                        style: TextStyle(fontSize: 20, fontFamily: 'monospace'),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("EXP: 12/28", style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 30),
                          Text("CVV: 999", style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            const Text(
              "Notice: The rest of the screen remains visible.\nOnly the sensitive card is blurred.",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => setState(() => _forceBlur = !_forceBlur),
              style: ElevatedButton.styleFrom(
                backgroundColor: _forceBlur ? Colors.green.shade100 : Colors.purple.shade100,
                foregroundColor: _forceBlur ? Colors.green : Colors.purple,
              ),
              child: Text(_forceBlur ? "Unlock Content" : "Force Manual Blur"),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

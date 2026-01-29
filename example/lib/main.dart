import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set this to true to prevent screenshots across the entire app
  PreventAppScreen.initialize(false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prevent App Screen',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGloballySecure = false;
  bool _isSpecificWidgetSecure = false;

  void _toggleGlobalSecure() async {
    final newState = !_isGloballySecure;
    await PreventAppScreen.initialize(newState);
    setState(() => _isGloballySecure = newState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prevent App Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: "Global Protection",
              description: "App-wide protection initialized in main().",
              isSecure: _isGloballySecure,
              onToggle: _toggleGlobalSecure,
              buttonText: _isGloballySecure ? "Disable Global" : "Enable Global",
            ),
            const SizedBox(height: 20),

            // This section demonstrates PreventWidget for a specific part of the UI
            PreventWidget(
              prevent: _isSpecificWidgetSecure,
              child: _buildSection(
                title: "Specific Widget Protection",
                description: "Only protects when this toggle is ON.",
                isSecure: _isSpecificWidgetSecure,
                onToggle: () => setState(() => _isSpecificWidgetSecure = !_isSpecificWidgetSecure),
                buttonText: _isSpecificWidgetSecure ? "Unlock UI" : "Lock UI",
                color: Colors.orange.shade50,
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecureScreen()),
                );
              },
              icon: const Icon(Icons.layers),
              label: const Text("Go to Protected Screen"),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required bool isSecure,
    required VoidCallback onToggle,
    required String buttonText,
    Color? color,
  }) {
    return Card(
      color: color,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  isSecure ? Icons.lock : Icons.lock_open,
                  color: isSecure ? Colors.green : Colors.red,
                  size: 32,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(description, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onToggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSecure ? Colors.red.shade100 : Colors.green.shade100,
                foregroundColor: isSecure ? Colors.red : Colors.green,
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class SecureScreen extends StatelessWidget {
  const SecureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // You can use PreventScreen (alias for PreventWidget)
    return const PreventScreen(
      child: Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 100, color: Colors.blue),
              SizedBox(height: 24),
              Text(
                'Full Screen Protection',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'This entire screen is protected by wrapping the Scaffold in PreventScreen.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

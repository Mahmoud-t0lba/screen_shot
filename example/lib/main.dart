import 'package:flutter/material.dart';
import 'package:prevent_app_screen/prevent_app_screen.dart';

import 'screens/full_screen_protection.dart';
import 'screens/specific_widget_protection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreventAppScreen.initialize(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protection Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protection Features'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LargeMenuButton(
                title: "Full Screen Protection",
                subtitle: "Protect the whole window",
                icon: Icons.fullscreen,
                color: Colors.blue,
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FullScreenProtectionScreen())),
              ),
              const SizedBox(height: 20),
              _LargeMenuButton(
                title: "Specific Widget Protection",
                subtitle: "Blur only a small part",
                icon: Icons.crop_free,
                color: Colors.purple,
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SpecificWidgetProtectionScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LargeMenuButton extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _LargeMenuButton(
      {required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

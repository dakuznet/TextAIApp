import 'package:flutter/material.dart';
import 'package:text_ai_app/screens/translate_screen.dart';
import 'package:text_ai_app/screens/generate_screen.dart';
import 'package:text_ai_app/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text AI App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.translate, size: 40),
                title: const Text(
                  'Text Translation',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text('Translate text between languages'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TranslateScreen(),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.auto_awesome, size: 40),
                title: const Text(
                  'Text Generation',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text('Generate text using AI'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GenerateScreen(),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

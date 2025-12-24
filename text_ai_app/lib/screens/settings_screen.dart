import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_ai_app/services/appwrite_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppwriteService>().currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Информация об аккаунте',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Имя'),
                      subtitle: Text(user?.name ?? 'Не указано'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Электронная почта'),
                      subtitle: Text(user?.email ?? 'Не указано'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Дата регистрации:'),
                      subtitle: Text(
                        user?.registration != null
                            ? DateTime.parse(
                                user!.registration,
                              ).toLocal().toString().split(' ')[0]
                            : 'Не указано',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<AppwriteService>().logout();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка при попытке выхода: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Выйти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

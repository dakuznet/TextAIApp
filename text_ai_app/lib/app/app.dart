import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_ai_app/screens/home_screen.dart';
import 'package:text_ai_app/screens/login_screen.dart';
import 'package:text_ai_app/services/appwrite_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text AI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Consumer<AppwriteService>(
        builder: (context, appwriteService, child) {
          if (appwriteService.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return appwriteService.isLoggedIn
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
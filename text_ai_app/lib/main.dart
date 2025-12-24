import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_ai_app/app/app.dart';
import 'package:text_ai_app/services/appwrite_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppwriteService())],
      child: const MyApp(),
    ),
  );
}
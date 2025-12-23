import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class AppwriteService extends ChangeNotifier {
  late Client client;
  late Account account;
  late Functions functions;

  bool _isLoading = true;
  bool _isLoggedIn = false;
  User? _currentUser;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;

  AppwriteService() {
    init();
  }

  Future<void> init() async {
    client = Client()
        .setEndpoint('https://fra.cloud.appwrite.io/v1')
        .setProject('694b149a003ad7352e18');

    account = Account(client);
    functions = Functions(client);

    await checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      _currentUser = await account.get();
      _isLoggedIn = true;
    } catch (e) {
      _isLoggedIn = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      await checkLoginStatus();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      await login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _isLoggedIn = false;
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      final execution = await functions.createExecution(
        functionId: '694b1c4d001127582332',
        body: json.encode({'text': text, 'target_language': targetLanguage}),
      );

      final response = json.decode(execution.responseBody);
      return response['translated_text'] ?? 'Error in translation';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> generateText(String prompt) async {
    try {
      final execution = await functions.createExecution(
        functionId: '694b1bfd0022499f58fc',
        body: json.encode({'prompt': prompt}),
      );

      final response = json.decode(execution.responseBody);
      return response['generated_text'] ?? 'Error in generation';
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:cgc_project/models/search_location/auto_completion_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageServices {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Future<void> setAuth(bool auth) async {
    await secureStorage.write(key: 'auth', value: auth.toString());
  }

  static Future<String?> get getAuth async {
    return await secureStorage.read(key: 'auth');
  }

  static Future<void> saveUserId(String userId) async {
    await secureStorage.write(key: 'userId', value: userId);
  }

  static Future<void> setAuthToken(String isAuthToken) async {
    await secureStorage.write(key: 'isAuthToken', value: isAuthToken);
  }

  static Future<void> setEmailId(String email) async {
    await secureStorage.write(key: 'email', value: email);
  }

  static Future<String?> get getAuthToken async {
    return await secureStorage.read(key: 'isAuthToken');
  }

  static Future<String?> get getUserId async {
    return await secureStorage.read(key: 'userId');
  }

  static Future<String?> get getEmailId async {
    return await secureStorage.read(key: 'email');
  }

  static Future<void> setSuggestionList(List<Suggestion> suggestions) async {
    final jsonString = jsonEncode(suggestions.map((s) => s.toJson()).toList());
    await secureStorage.write(key: 'suggestion', value: jsonString);
  }

  static Future<List<Suggestion>> getSuggestionList() async {
    final jsonString = await secureStorage.read(key: 'suggestion');
    if (jsonString == null) return [];
    final List decodedList = jsonDecode(jsonString);
    return decodedList.map((json) => Suggestion.fromJson(json)).toList();
  }
}

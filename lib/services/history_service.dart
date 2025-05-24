
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _key = 'historial';

  /// Guarda la lista del historial como JSON en SharedPreferences
  static Future<void> saveHistory(List<Map<String, dynamic>> history) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(history);
    await prefs.setString(_key, jsonString);
  }

  /// Carga la lista del historial desde SharedPreferences
  static Future<List<Map<String, dynamic>>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  /// Borra el historial guardado
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application_about_me/domain/models/description_model.dart';

class DescriptionRepository {
  static const _kDescriptionsKey = 'descriptions_key';

  List<Description> _description = [];
  int _nextId = 0;

  Future<void> loadDescriptions() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonStringList = prefs.getStringList(_kDescriptionsKey);

    if (jsonStringList != null) {
      _description = jsonStringList.map((jsonString) {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return Description.fromJson(jsonMap);
      }).toList();
      
      if (_description.isNotEmpty) {
        _nextId = _description.map((d) => d.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    }
  }

  Future<void> _saveDescriptions() async {
    final prefs = await SharedPreferences.getInstance();
    
    final jsonStringList = _description.map((description) {
      final jsonMap = description.toJson();
      return jsonEncode(jsonMap);
    }).toList();

    await prefs.setStringList(_kDescriptionsKey, jsonStringList);
  }

  List<Description> getAllDescriptions() => List.unmodifiable(_description);

  Future<void> addDescription(String title, String text) async {
    final newDescription = Description(
      id: _nextId,
      title: title,
      text: text,
    );
    _description.add(newDescription);
    _nextId++;
    
    await _saveDescriptions();
  }

  Future<void> updateDescription(Description oldDescription, Description newDescription) async {
    final index = _description.indexWhere((d) => d.id == oldDescription.id);
    if (index != -1) {
      final updatedDescription = Description(
        id: oldDescription.id,
        title: newDescription.title,
        text: newDescription.text,
      );
      _description[index] = updatedDescription;
      
      await _saveDescriptions();
    }
  }

  Future<void> deleteDescription(int id) async {
    _description.removeWhere((description) => description.id == id);
  
    await _saveDescriptions();
  }
}

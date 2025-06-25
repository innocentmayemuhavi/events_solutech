import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/_models.dart';

class DataService {
  static const String _customersPath = 'assets/json/customers.json';
  static const String _activitiesPath = 'assets/json/activities.json';
  static const String _visitsPath = 'assets/json/visits.json';

  // Load customers from JSON
  static Future<List<Customer>> loadCustomers() async {
    try {
      final String jsonString = await rootBundle.loadString(_customersPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> customersJson = jsonData['customers'];

      return customersJson.map((json) => Customer.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  // Load activities from JSON
  static Future<List<Activity>> loadActivities() async {
    try {
      final String jsonString = await rootBundle.loadString(_activitiesPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> activitiesJson = jsonData['activities'];

      return activitiesJson.map((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load activities: $e');
    }
  }

  // Load visits from JSON
  static Future<List<Visit>> loadVisits() async {
    try {
      final String jsonString = await rootBundle.loadString(_visitsPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> visitsJson = jsonData['visits'];

      return visitsJson.map((json) => Visit.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load visits: $e');
    }
  }
}

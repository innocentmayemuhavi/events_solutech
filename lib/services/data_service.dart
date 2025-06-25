import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/_models.dart';

class DataService {
  static const String _baseUrl =
      'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1';
  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c';

  static Map<String, String> get _headers => {
    'apikey': _apiKey,
    'Authorization': 'Bearer $_apiKey',
    'Content-Type': 'application/json',
    'Prefer': 'return=representation',
  };

  // Load customers from Supabase API
  static Future<List<Customer>> loadCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/customers'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> customersJson = json.decode(response.body);
        return customersJson.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (e) {
      throw Exception('Failed to load customers');
    }
  }

  // Load activities from Supabase API
  static Future<List<Activity>> loadActivities() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/activities'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> activitiesJson = json.decode(response.body);
        return activitiesJson.map((json) => Activity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load activities');
      }
    } catch (e) {
      throw Exception('Failed to load activities');
    }
  }

  // Load visits from Supabase API
  static Future<List<Visit>> loadVisits() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/visits'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> visitsJson = json.decode(response.body);
        return visitsJson.map((json) => Visit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (e) {
      throw Exception('Failed to load visits');
    }
  }

  // Add new visit to Supabase API
  static Future<Visit> addVisit(Visit visit) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/visits'),
        headers: _headers,
        body: json.encode({
          'customer_id': visit.customerId,
          'visit_date': visit.visitDate.toIso8601String(),
          'status': visit.status,
          'location': visit.location,
          'notes': visit.notes,
          'activities_done': visit.activitiesDone,
        }),
      );

      if (response.statusCode == 201) {
        final List<dynamic> responseData = json.decode(response.body);
        return Visit.fromJson(responseData.first);
      } else {
        throw Exception('Failed to add visit');
      }
    } catch (e) {
      throw Exception('Failed to add visit: $e');
    }
  }

  // Update visit in Supabase API
  static Future<Visit> updateVisit(Visit visit) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/visits?id=eq.${visit.id}'),
        headers: _headers,
        body: json.encode({
          'customer_id': visit.customerId,
          'visit_date': visit.visitDate.toIso8601String(),
          'status': visit.status,
          'location': visit.location,
          'notes': visit.notes,
          'activities_done': visit.activitiesDone,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return Visit.fromJson(responseData.first);
      } else {
        throw Exception('Failed to update visit: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update visit: $e');
    }
  }

  // Delete visit from Supabase API
  static Future<void> deleteVisit(int visitId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/visits?id=eq.$visitId'),
        headers: _headers,
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete visit: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete visit: $e');
    }
  }

  // Get visits by customer ID
  static Future<List<Visit>> getVisitsByCustomer(int customerId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/visits?customer_id=eq.$customerId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> visitsJson = json.decode(response.body);
        return visitsJson.map((json) => Visit.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load visits by customer: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load visits by customer: $e');
    }
  }
}

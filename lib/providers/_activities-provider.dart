import 'package:events_solutech/services/_data-service.dart';
import 'package:flutter/foundation.dart';
import '../models/_models.dart';

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [];
  bool _isLoading = false;
  String? _error;

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get activity by ID
  Activity? getActivityById(int id) {
    try {
      return _activities.firstWhere((activity) => activity.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get activities by IDs
  List<Activity> getActivitiesByIds(List<int> ids) {
    return _activities.where((activity) => ids.contains(activity.id)).toList();
  }

  // Load activities from JSON
  Future<void> loadActivities() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _activities = await DataService.loadActivities();
      _error = null;
    } catch (e) {
      _error = 'Failed to load activities: $e';
      _activities = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new activity (for future use)
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }
}

import 'package:events_solutech/services/data_service.dart';
import 'package:flutter/foundation.dart';
import '../models/_models.dart';

enum VisitStatus { all, completed, pending, cancelled }

class VisitsProvider with ChangeNotifier {
  List<Visit> _visits = [];
  bool _isLoading = false;
  String? _error;

  List<Visit> get visits => _visits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get visits by status
  List<Visit> getVisitsByStatus(String status) {
    return _visits
        .where((visit) => visit.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  // Get visits by customer ID
  List<Visit> getVisitsByCustomer(int customerId) {
    return _visits.where((visit) => visit.customerId == customerId).toList();
  }

  // Get visit statistics
  Map<String, int> getVisitStats() {
    final stats = <String, int>{
      'total': _visits.length,
      'completed': _visits
          .where((v) => v.status.toLowerCase() == 'completed')
          .length,
      'pending': _visits
          .where((v) => v.status.toLowerCase() == 'pending')
          .length,
      'cancelled': _visits
          .where((v) => v.status.toLowerCase() == 'cancelled')
          .length,
    };
    return stats;
  }

  // Search visits (by customer, location, or notes)
  List<Visit> searchVisits(String query, List<Customer> customers) {
    if (query.isEmpty) return _visits;

    return _visits.where((visit) {
      final customer = customers.firstWhere(
        (c) => c.id == visit.customerId,
        orElse: () => Customer(id: 0, name: '', createdAt: DateTime.now()),
      );

      return customer.name.toLowerCase().contains(query.toLowerCase()) ||
          visit.location.toLowerCase().contains(query.toLowerCase()) ||
          visit.notes.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Filter visits by date range
  List<Visit> getVisitsByDateRange(DateTime start, DateTime end) {
    return _visits
        .where(
          (visit) =>
              visit.visitDate.isAfter(start.subtract(Duration(days: 1))) &&
              visit.visitDate.isBefore(end.add(Duration(days: 1))),
        )
        .toList();
  }

  // Load visits from JSON
  Future<void> loadVisits() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _visits = await DataService.loadVisits();
      // Sort visits by visit date (most recent first)
      _visits.sort((a, b) => b.visitDate.compareTo(a.visitDate));
      _error = null;
    } catch (e) {
      _error = 'Failed to load visits: $e';
      _visits = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new visit
  void addVisit(Visit visit) {
    _visits.add(visit);
    // Re-sort after adding
    _visits.sort((a, b) => b.visitDate.compareTo(a.visitDate));
    notifyListeners();
  }

  // Update visit
  void updateVisit(Visit updatedVisit) {
    final index = _visits.indexWhere((v) => v.id == updatedVisit.id);
    if (index != -1) {
      _visits[index] = updatedVisit;
      // Re-sort after updating
      _visits.sort((a, b) => b.visitDate.compareTo(a.visitDate));
      notifyListeners();
    }
  }

  // Delete visit
  void deleteVisit(int visitId) {
    _visits.removeWhere((v) => v.id == visitId);
    notifyListeners();
  }

  // Update visit status
  void updateVisitStatus(int visitId, String newStatus) {
    final index = _visits.indexWhere((v) => v.id == visitId);
    if (index != -1) {
      final visit = _visits[index];
      final updatedVisit = Visit(
        id: visit.id,
        customerId: visit.customerId,
        visitDate: visit.visitDate,
        status: newStatus,
        location: visit.location,
        notes: visit.notes,
        activitiesDone: visit.activitiesDone,
        createdAt: visit.createdAt,
      );
      _visits[index] = updatedVisit;
      notifyListeners();
    }
  }
}

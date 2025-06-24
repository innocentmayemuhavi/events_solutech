import 'package:events_solutech/services/_data-service.dart';
import 'package:flutter/foundation.dart';
import '../models/_models.dart';

class CustomersProvider with ChangeNotifier {
  List<Customer> _customers = [];
  bool _isLoading = false;
  String? _error;

  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get customer by ID
  Customer? getCustomerById(int id) {
    try {
      return _customers.firstWhere((customer) => customer.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search customers by name
  List<Customer> searchCustomers(String query) {
    if (query.isEmpty) return _customers;

    return _customers
        .where(
          (customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Load customers from JSON
  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _customers = await DataService.loadCustomers();
      _error = null;
    } catch (e) {
      _error = 'Failed to load customers: $e';
      _customers = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new customer (for future use)
  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  // Update customer (for future use)
  void updateCustomer(Customer updatedCustomer) {
    final index = _customers.indexWhere((c) => c.id == updatedCustomer.id);
    if (index != -1) {
      _customers[index] = updatedCustomer;
      notifyListeners();
    }
  }

  // Delete customer (for future use)
  void deleteCustomer(int customerId) {
    _customers.removeWhere((c) => c.id == customerId);
    notifyListeners();
  }
}

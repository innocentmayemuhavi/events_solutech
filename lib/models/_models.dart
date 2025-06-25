
import 'package:events_solutech/utils/utils.dart';

class Customer {
  final int id;
  final String name;
  final DateTime createdAt;

  Customer({required this.id, required this.name, required this.createdAt});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Activity {
  final int id;
  final String description;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.description,
    required this.createdAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Visit {
  final int id;
  final int customerId;
  final DateTime visitDate;
  final String status;
  final String location;
  final String notes;
  final List<int> activitiesDone;
  final DateTime createdAt;

  Visit({
    required this.id,
    required this.customerId,
    required this.visitDate,
    required this.status,
    required this.location,
    required this.notes,
    required this.activitiesDone,
    required this.createdAt,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      visitDate: DateTime.parse(
        json['visit_date'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? '',
      location: json['location'] ?? '',
      notes: json['notes'] ?? '',
      activitiesDone: parseActivitiesDone(json['activities_done']),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

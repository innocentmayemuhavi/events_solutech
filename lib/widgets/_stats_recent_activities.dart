import 'package:flutter/material.dart';
import '../models/_models.dart';

Widget buildRecentActivitySection(BuildContext context, List<Visit> visits) {
  final recentVisits = visits.take(3).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Activity',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: recentVisits.map((visit) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getStatusColor(visit.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  getStatusIcon(visit.status),
                  color: getStatusColor(visit.status),
                  size: 20,
                ),
              ),
              title: Text(
                visit.location,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${visit.status} • ${formatDate(visit.visitDate)}',
              ),
              trailing: Text(
                formatTime(visit.visitDate),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

IconData getStatusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Icons.check_circle;
    case 'pending':
      return Icons.schedule;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.help_outline;
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

String formatTime(DateTime date) {
  return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}

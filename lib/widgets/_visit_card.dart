import 'package:events_solutech/models/_models.dart';
import 'package:events_solutech/providers/activities_provider.dart';
import 'package:events_solutech/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({super.key, required this.visit, this.onTap});

  final Visit visit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer2<CustomersProvider, ActivitiesProvider>(
      builder: (context, customersProvider, activitiesProvider, child) {
        // Fetch customer details
        final customer = customersProvider.getCustomerById(visit.customerId);

        // Fetch activities for this visit
        final visitActivities = activitiesProvider.getActivitiesByIds(
          visit.activitiesDone,
        );

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: .2,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(
                visit.status,
              ).withValues(alpha: 0.1),
              child: Text(
                '#${visit.id}',
                style: TextStyle(
                  color: _getStatusColor(visit.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            title: Text(
              customer?.name ?? 'Unknown Customer',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        visit.location,
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          visit.status,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        visit.status,
                        style: TextStyle(
                          color: _getStatusColor(visit.status),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (visitActivities.isNotEmpty)
                      Expanded(
                        child: Text(
                          '${visitActivities.length} activities',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
                if (visit.notes.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    visit.notes,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatDate(visit.visitDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTime(visit.visitDate),
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                ),
                const SizedBox(height: 4),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
            onTap:
                onTap ??
                () => _showVisitDetails(
                  context,
                  visit,
                  customer,
                  visitActivities,
                ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showVisitDetails(
    BuildContext context,
    Visit visit,
    Customer? customer,
    List<Activity> activities,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Visit Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Customer', customer?.name ?? 'Unknown'),
              _buildDetailRow('Location', visit.location),
              _buildDetailRow('Date', _formatDate(visit.visitDate)),
              _buildDetailRow('Time', _formatTime(visit.visitDate)),
              _buildDetailRow('Status', visit.status),
              if (visit.notes.isNotEmpty) _buildDetailRow('Notes', visit.notes),
              if (activities.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Activities:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                ...activities.map(
                  (activity) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 2),
                    child: Text('• ${activity.description}'),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

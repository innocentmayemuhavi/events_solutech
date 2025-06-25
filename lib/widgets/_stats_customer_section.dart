import 'package:flutter/material.dart';
import '../models/_models.dart';

Widget buildCustomerSection(
  BuildContext context,
  List<Visit> visits,
  List<Customer> customers,
) {
  // Calculate customer visit counts
  final customerVisitCounts = <int, int>{};
  for (final visit in visits) {
    customerVisitCounts[visit.customerId] =
        (customerVisitCounts[visit.customerId] ?? 0) + 1;
  }

  // Sort customers by visit count
  final sortedCustomers = customers
      .where((c) => customerVisitCounts.containsKey(c.id))
      .toList();
  sortedCustomers.sort(
    (a, b) => (customerVisitCounts[b.id] ?? 0).compareTo(
      customerVisitCounts[a.id] ?? 0,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Top Customers',
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
              color: Colors.grey.withValues(alpha: .1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: sortedCustomers.take(5).map((customer) {
            final visitCount = customerVisitCounts[customer.id] ?? 0;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: .1),
                child: Text(
                  customer.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                customer.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$visitCount visits',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

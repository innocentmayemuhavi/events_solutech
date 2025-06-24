import 'package:events_solutech/shared/_themes.dart';
import 'package:flutter/material.dart';

Widget buildStatsHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.05), primaryColor.withOpacity(0.3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),

      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.analytics_outlined, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analytics Dashboard',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Track your visits and activities',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

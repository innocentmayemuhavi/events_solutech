import 'package:flutter/material.dart';
import '../models/_models.dart';

Widget buildActivitiesSection(
  BuildContext context,
  List<Visit> visits,
  List<Activity> activities,
) {
  // Calculate activity statistics
  final activityStats = <int, int>{};
  for (final visit in visits) {
    for (final activityId in visit.activitiesDone) {
      activityStats[activityId] = (activityStats[activityId] ?? 0) + 1;
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Activity Statistics',
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
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: activities.take(5).map((activity) {
            final count = activityStats[activity.id] ?? 0;
            final maxCount = activityStats.values.isEmpty
                ? 1
                : activityStats.values.reduce((a, b) => a > b ? a : b);
            final progress = maxCount > 0 ? count / maxCount : 0.0;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      getActivityIcon(activity.description),
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.description,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 1000),
                          tween: Tween(begin: 0.0, end: progress),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: value,
                                    child: Container(
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

IconData getActivityIcon(String description) {
  switch (description.toLowerCase()) {
    case 'product demonstration':
      return Icons.play_circle_outline;
    case 'technical consultation':
      return Icons.engineering_outlined;
    case 'contract negotiation':
      return Icons.handshake_outlined;
    case 'follow-up meeting':
      return Icons.follow_the_signs_outlined;
    case 'problem resolution':
      return Icons.build_circle_outlined;
    case 'training session':
      return Icons.school_outlined;
    case 'system installation':
      return Icons.settings_applications_outlined;
    case 'maintenance check':
      return Icons.tune_outlined;
    case 'sales presentation':
      return Icons.present_to_all_outlined;
    case 'customer feedback collection':
      return Icons.feedback_outlined;
    default:
      return Icons.work_outline;
  }
}

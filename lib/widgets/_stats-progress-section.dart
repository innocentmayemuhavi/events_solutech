import 'package:flutter/material.dart';

class StatsProgressSection extends StatelessWidget {
  final Map<String, int> visitStats;

  const StatsProgressSection({super.key, required this.visitStats});

  @override
  Widget build(BuildContext context) {
    final total = visitStats['total'] ?? 1;
    if (total == 0) {
      return const SizedBox.shrink();
    }

    final completed = visitStats['completed'] ?? 0;
    final pending = visitStats['pending'] ?? 0;
    final cancelled = visitStats['cancelled'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Overview',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ProgressCard(
          title: 'Completion Rate',
          progress: completed / total,
          color: Colors.green,
          subtitle: '$completed/$total completed',
        ),
        const SizedBox(height: 12),
        ProgressCard(
          title: 'Pending Rate',
          progress: pending / total,
          color: Colors.orange,
          subtitle: '$pending/$total pending',
        ),
        const SizedBox(height: 12),
        ProgressCard(
          title: 'Cancellation Rate',
          progress: cancelled / total,
          color: Colors.red,
          subtitle: '$cancelled/$total cancelled',
        ),
      ],
    );
  }
}

class ProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;
  final String subtitle;

  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween(begin: 0.0, end: progress),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

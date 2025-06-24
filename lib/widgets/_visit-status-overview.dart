import 'package:flutter/material.dart';

Widget buildVisitStatusOverview(
  BuildContext context,
  Map<String, int> visitStats,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Visit Status Overview',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
        children: [
          buildAnimatedStatCard(
            context: context,
            title: 'Total Visits',
            value: visitStats['total']?.toString() ?? '0',
            icon: Icons.assignment_outlined,
            color: Colors.blue,
            delay: 0,
          ),
          buildAnimatedStatCard(
            context: context,
            title: 'Completed',
            value: visitStats['completed']?.toString() ?? '0',
            icon: Icons.check_circle_outline,
            color: Colors.green,
            delay: 100,
          ),
          buildAnimatedStatCard(
            context: context,
            title: 'Pending',
            value: visitStats['pending']?.toString() ?? '0',
            icon: Icons.schedule_outlined,
            color: Colors.orange,
            delay: 200,
          ),
          buildAnimatedStatCard(
            context: context,
            title: 'Cancelled',
            value: visitStats['cancelled']?.toString() ?? '0',
            icon: Icons.cancel_outlined,
            color: Colors.red,
            delay: 300,
          ),
        ],
      ),
    ],
  );
}

Widget buildAnimatedStatCard({
  required BuildContext context,
  required String title,
  required String value,
  required IconData icon,
  required Color color,
  required int delay,
}) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 800 + delay),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.elasticOut,
    builder: (context, animation, child) {
      return Transform.scale(
        scale: animation,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

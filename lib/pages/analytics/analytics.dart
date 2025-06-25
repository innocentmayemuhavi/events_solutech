import 'package:events_solutech/widgets/_stats_activities_section.dart';
import 'package:events_solutech/widgets/_stats_customer_section.dart';
import 'package:events_solutech/widgets/_stats_progress_section.dart';
import 'package:events_solutech/widgets/_stats_recent_activities.dart';
import 'package:events_solutech/widgets/_visit_status_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/visits_provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/activities_provider.dart';
import '../../widgets/_stats_header.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<VisitsProvider, CustomersProvider, ActivitiesProvider>(
        builder:
            (
              context,
              visitsProvider,
              customersProvider,
              activitiesProvider,
              child,
            ) {
              if (visitsProvider.isLoading ||
                  customersProvider.isLoading ||
                  activitiesProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final visitStats = visitsProvider.getVisitStats();
              final visits = visitsProvider.visits;
              final customers = customersProvider.customers;
              final activities = activitiesProvider.activities;

              return AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStatsHeader(context),
                        const SizedBox(height: 20),

                        buildVisitStatusOverview(context, visitStats),
                        const SizedBox(height: 20),

                        StatsProgressSection(visitStats: visitStats),
                        const SizedBox(height: 20),

                        buildActivitiesSection(context, visits, activities),
                        const SizedBox(height: 20),

                        buildCustomerSection(context, visits, customers),
                        const SizedBox(height: 20),

                        buildRecentActivitySection(context, visits),
                      ],
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}

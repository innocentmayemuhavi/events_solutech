import 'package:events_solutech/app_main.dart';
import 'package:events_solutech/providers/activities_provider.dart';
import 'package:events_solutech/providers/customer_provider.dart';
import 'package:events_solutech/providers/visits_provider.dart';
import 'package:events_solutech/shared/_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomersProvider()),
        ChangeNotifierProvider(create: (_) => VisitsProvider()),
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
      ],
      child: MaterialApp(
        home: AppMainWrapper(),
        debugShowCheckedModeBanner: false,
        title: 'Visits Tracker',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class AppMainWrapper extends StatefulWidget {
  const AppMainWrapper({super.key});

  @override
  State<AppMainWrapper> createState() => _AppMainWrapperState();
}

class _AppMainWrapperState extends State<AppMainWrapper> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    try {
      if (mounted) {
        await context.read<CustomersProvider>().loadCustomers();
        // ignore: use_build_context_synchronously
        await context.read<VisitsProvider>().loadVisits();
        // ignore: use_build_context_synchronously
        await context.read<ActivitiesProvider>().loadActivities();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppMain();
  }
}

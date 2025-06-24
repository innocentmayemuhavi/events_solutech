import 'package:events_solutech/_app-main.dart';
import 'package:events_solutech/providers/_activities-provider.dart';
import 'package:events_solutech/providers/_customer-provider.dart';
import 'package:events_solutech/providers/_visits-provider.dart';
import 'package:events_solutech/providers/index.dart';
import 'package:events_solutech/shared/_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  @override
  State<AppMainWrapper> createState() => _AppMainWrapperState();
}

class _AppMainWrapperState extends State<AppMainWrapper> {
  @override
  void initState() {
    super.initState();
    // Load data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    try {
      if (mounted) {
        await context.read<CustomersProvider>().loadCustomers();
        await context.read<VisitsProvider>().loadVisits();
        await context.read<ActivitiesProvider>().loadActivities();
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppMain();
  }
}

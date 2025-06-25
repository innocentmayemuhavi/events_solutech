import 'package:events_solutech/providers/activities_provider.dart';
import 'package:events_solutech/providers/customer_provider.dart';
import 'package:events_solutech/providers/visits_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> get providers => [
  ChangeNotifierProvider(create: (_) => CustomersProvider()),
  ChangeNotifierProvider(create: (_) => VisitsProvider()),
  ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
];

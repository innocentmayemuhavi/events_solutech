import 'package:events_solutech/providers/_activities-provider.dart';
import 'package:events_solutech/providers/_customer-provider.dart';
import 'package:events_solutech/providers/_visits-provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> get providers => [
  ChangeNotifierProvider(create: (_) => CustomersProvider()),
  ChangeNotifierProvider(create: (_) => VisitsProvider()),
  ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
];

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:events_solutech/app_main.dart';
import 'package:events_solutech/providers/activities_provider.dart';
import 'package:events_solutech/providers/customer_provider.dart';
import 'package:events_solutech/providers/visits_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App shows main widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CustomersProvider()),
          ChangeNotifierProvider(create: (_) => VisitsProvider()),
          ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
        ],
        child: MaterialApp(home: AppMain()),
      ),
    );

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that the app shows the main widgets
    expect(find.text('Visits Tracker'), findsOneWidget);
    expect(find.text('Visits'), findsOneWidget);
    expect(find.text('Add Visit'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
  });
}

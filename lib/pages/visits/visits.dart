import 'package:events_solutech/providers/customer_provider.dart';
import 'package:events_solutech/providers/visits_provider.dart';
import 'package:events_solutech/widgets/_visit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by customer name, location, or notes...',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<VisitsProvider>(
                builder: (context, visitsProvider, child) {
                  if (visitsProvider.isLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(radius: 15),
                    );
                  }

                  if (visitsProvider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            visitsProvider.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<VisitsProvider>().loadVisits();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final visits = searchQuery.isEmpty
                      ? visitsProvider.visits
                      : visitsProvider.searchVisits(
                          searchQuery,
                          context.read<CustomersProvider>().customers,
                        );

                  if (visits.isEmpty) {
                    return const Center(child: Text('No visits found'));
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      final visit = visits[index];
                      return VisitCard(visit: visit, onTap: () {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

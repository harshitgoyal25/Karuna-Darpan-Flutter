import 'package:flutter/material.dart';

class MorphineStockPage extends StatelessWidget {
  const MorphineStockPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Morphine Stock Low',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF3E1F99),
          leading: const BackButton(color: Colors.white),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.amber),
              title: Text(
                'Morphine Stock Low',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Please restock before the supply is depleted.'),
            ),
            const SizedBox(height: 12),
            const Text(
              '34 Units Remaining',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            const Text(
              'Recent Restocks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ...[
              "Aug 7, 2024",
              "Aug 24, 2024",
              "Sep 7, 2024",
              "Jan 7, 2025",
              "Feb 9, 2025"
            ].map((date) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: const Text('100 Units'),
                    subtitle: Text('Restocked on $date'),
                    leading: const Icon(Icons.inventory_2),
                  ),
                )),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add stock logic
                },
                icon: const Icon(Icons.report_problem),
                label: const Text('Restock Morphine'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      );
}

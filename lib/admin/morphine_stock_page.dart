import 'package:flutter/material.dart';

class MorphineStockPage extends StatelessWidget {
  const MorphineStockPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Morphine Stock Low'),
          backgroundColor: const Color(0xFF3E1F99),
          leading: const BackButton(color: Colors.white,), 
          
          actions: const [
            CircleAvatar(backgroundImage: AssetImage('assets/avatar.png'))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.amber),
              title: Text('Morphine Stock Low', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Please restock before the supply is depleted.'),
            ),
            const Text('34 Units Remaining', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            const Text('Recent Restocks'),
            ...["Aug 7, 2024", "Aug 24, 2024", "Sep 7, 2024", "Jan 7, 2025", "Feb 9, 2025"].map(
              (date) => ListTile(
                title: const Text('100 Units'),
                subtitle: Text('Restocked on $date'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.report_problem),
              label: const Text('Restock Morphine'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                shape: const StadiumBorder(),
              ),
            ),
          ],
        ),
      );
}
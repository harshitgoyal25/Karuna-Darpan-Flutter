import 'package:flutter/material.dart';

class HighRiskPage extends StatelessWidget {
  const HighRiskPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'High-Risk Patient',
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
            const Text(
              'Patient Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text('20 Years, Female\nID 12345'),
            const SizedBox(height: 20),
            const Text(
              'High Risk Flags',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.warning, color: Colors.orange),
                title: Text('Diabetes'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Care Plans',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.medical_services, color: Colors.blue),
                title: Text('Diabetes Management'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Last Visit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text('Aug 24, 2024'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  label: const Text('Add Flags'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E1F99),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Update Visit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';

class HighRiskPage extends StatelessWidget {
  const HighRiskPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('High-Risk Patient'),
          backgroundColor: const Color(0xFF3E1F99),
          leading: const BackButton(color: Colors.white),
          actions: const [
            CircleAvatar(backgroundImage: AssetImage('assets/avatar.png'))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Patient Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('20 Years , Female\nID 12345'),
            SizedBox(height: 20),
            Text('High Risk Flags',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                child: ListTile(
                    leading: Icon(Icons.warning), title: Text('Diabetes'))),
            SizedBox(height: 20),
            Text('Care Plans',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                child: ListTile(
                    leading: Icon(Icons.warning),
                    title: Text('Diabetes Management'))),
            SizedBox(height: 20),
            Text('Last Visit',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Aug 24, 2024'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
      onPressed: () {},
                    icon: Icon(Icons.star_border),
                    label: Text('Add Flags')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.open_in_new),
                    label: Text('Update Visit')),
              ],
            ),
          ],
        ),
      );
}

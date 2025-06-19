import 'package:flutter/material.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Referrals'),
          backgroundColor: const Color(0xFF3E1F99),
          leading: const BackButton(color: Colors.white),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text('Export', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _referralCard('Nidhi B.', 'Specialist Consult', 'Feb 4', 'Pending'),
            _referralCard('NNNNNNN', 'Uncontrolled Pain', 'Feb 8', 'Complete'),
            _referralCard('Nidhi B', 'High Decoration Risk', 'Feb 4', 'Pending'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/new-referral');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Referral'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/all-referrals');
                  },
                  child: const Text('View All'),
                ),
              ],
            )
          ],
        ),
      );

  Widget _referralCard(String name, String reason, String date, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$reason\n$date'),
        trailing: Chip(
          label: Text(status),
          backgroundColor:
              status == 'Complete' ? Colors.green[100] : Colors.pink[50],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HealthHistoryPage extends StatefulWidget {
  const HealthHistoryPage({super.key});

  @override
  State<HealthHistoryPage> createState() => _HealthHistoryPageState();
}

class _HealthHistoryPageState extends State<HealthHistoryPage> {
  final List<Map<String, String>> history = [
    {'date': '2 June, 2025', 'event': 'Monthly Health Checkup - ABC Clinic'},
    {'date': '13 May, 2025', 'event': 'Emergency Checkup - AC Hospital'},
    {'date': '2 May, 2025', 'event': 'Monthly Health Checkup - ABC Clinic'},
  ];

  final TextEditingController dateController = TextEditingController();
  final TextEditingController eventController = TextEditingController();

  void _showAddRecordSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding:
            MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Health Record',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date (e.g. 10 June, 2025)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: eventController,
              decoration: const InputDecoration(
                labelText: 'Event',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final date = dateController.text.trim();
                final event = eventController.text.trim();
                if (date.isNotEmpty && event.isNotEmpty) {
                  setState(() {
                    history.insert(0, {'date': date, 'event': event});
                  });
                  dateController.clear();
                  eventController.clear();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Add Record',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadHistory() {
    // Placeholder for download functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download not implemented yet')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text('Health History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['date']!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 6),
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(item['event']!),
                  leading: const Icon(Icons.medical_services_outlined),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _downloadHistory,
                icon: const Icon(Icons.download),
                label: const Text('Download'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _showAddRecordSheet,
                icon: const Icon(Icons.add),
                label: const Text('Add Record'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

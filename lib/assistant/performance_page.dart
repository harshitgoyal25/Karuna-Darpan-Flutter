import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = {
      'No. of visit conducted': '45',
      'No. of Patients reffered': '20',
      'No. of caregiver trained': '13',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Performance'),
        backgroundColor: const Color(0xFF3E1F99),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: stats.entries
            .map((e) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(e.value,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Text(e.key,
                              style:
                                  const TextStyle(fontSize: 16))),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

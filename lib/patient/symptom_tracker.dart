import 'package:flutter/material.dart';

class SymptomTrackerPage extends StatelessWidget {
  const SymptomTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController symptomsController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController historyController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Symptom Tracker'),
        backgroundColor: const Color(0xFF6A3BFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('What symptoms are you experiencing?'),
            TextField(
              controller: symptomsController,
              decoration: const InputDecoration(hintText: 'Headache, Fever, etc.'),
            ),
            const SizedBox(height: 16),
            const Text('How long have you had these symptoms?'),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(hintText: '2 days'),
            ),
            const SizedBox(height: 16),
            const Text('Any medical history?'),
            TextField(
              controller: historyController,
              decoration: const InputDecoration(hintText: 'Asthma, Diabetes'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SymptomResultsPage(
                      symptoms: symptomsController.text,
                      duration: durationController.text,
                      history: historyController.text,
                    ),
                  ),
                );
              },
              child: const Text('Get Results'),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomResultsPage extends StatelessWidget {
  final String symptoms;
  final String duration;
  final String history;

  const SymptomResultsPage({
    super.key,
    required this.symptoms,
    required this.duration,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: const Color(0xFF6A3BFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Based on your input:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text('Symptoms: $symptoms'),
            Text('Duration: $duration'),
            Text('History: $history'),
            const SizedBox(height: 24),
            const Text(
              'Possible Causes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('- Common Cold'),
            const Text('- Viral Fever'),
            const Text('- Flu or Infection'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}

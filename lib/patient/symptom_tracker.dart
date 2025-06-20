import 'package:flutter/material.dart';

class SymptomTrackerPage extends StatelessWidget {
  const SymptomTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController symptomsController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController historyController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Symptom Tracker',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What symptoms are you experiencing?'),
            const SizedBox(height: 6),
            TextField(
              controller: symptomsController,
              decoration: InputDecoration(
                hintText: 'Headache, Fever, etc.',
                filled: true,
                fillColor: Colors.grey.shade100,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('How long have you had these symptoms?'),
            const SizedBox(height: 6),
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                hintText: '2 days',
                filled: true,
                fillColor: Colors.grey.shade100,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Any medical history?'),
            const SizedBox(height: 6),
            TextField(
              controller: historyController,
              decoration: InputDecoration(
                hintText: 'Asthma, Diabetes',
                filled: true,
                fillColor: Colors.grey.shade100,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
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
                child: const Text('Get Results',
                    style: TextStyle(color: Colors.white)),
              ),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Results', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Based on your input:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text('📝 Symptoms: $symptoms'),
            Text('⏱️ Duration: $duration'),
            Text('📋 History: $history'),
            const SizedBox(height: 24),
            const Text(
              'Possible Causes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('- Common Cold'),
            const Text('- Viral Fever'),
            const Text('- Flu or Infection'),
            const SizedBox(height: 24),
            Center(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

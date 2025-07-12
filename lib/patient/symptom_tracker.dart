import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SymptomTrackerPage extends StatefulWidget {
  const SymptomTrackerPage({super.key});

  @override
  State<SymptomTrackerPage> createState() => _SymptomTrackerPageState();
}

class _SymptomTrackerPageState extends State<SymptomTrackerPage> {
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController historyController = TextEditingController();

  @override
  void dispose() {
    symptomsController.dispose();
    durationController.dispose();
    historyController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final symptoms = symptomsController.text.trim();
    final duration = durationController.text.trim();
    final history = historyController.text.trim();

    if (symptoms.isEmpty || duration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SymptomResultsPage(
          symptoms: symptoms,
          duration: duration,
          history: history,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            const Text('Any medical history? (Optional)'),
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
                onPressed: _submitForm,
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

Future<String> getAIAnalysis(
    String symptoms, String duration, String history) async {
  const apiKey = 'a7712f6215a5638026041f084e8c4d22d546dd81c9d656cf43d4119212927e62'; // 🔑 Replace this with your actual key
  const String apiUrl = 'https://api.together.xyz/v1/chat/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      "model": "mistralai/Mistral-7B-Instruct-v0.2",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a helpful medical assistant that gives likely causes of symptoms based on patient input."
        },
        {
          "role": "user",
          "content": "A patient has:\n"
              "- Symptoms: $symptoms\n"
              "- Duration: $duration\n"
              "- Medical History: $history\n"
              "What are the most likely causes?"
        }
      ],
      "temperature": 0.7,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['choices'][0]['message']['content'];
  } else {
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    throw Exception('Failed to get AI analysis');
  }
}
class SymptomResultsPage extends StatefulWidget {
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
  State<SymptomResultsPage> createState() => _SymptomResultsPageState();
}

class _SymptomResultsPageState extends State<SymptomResultsPage> {
  String? aiResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAIResult();
  }

  Future<void> fetchAIResult() async {
    try {
      final result = await getAIAnalysis(
        widget.symptoms,
        widget.duration,
        widget.history,
      );
      setState(() {
        aiResult = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        aiResult = 'Error retrieving AI analysis: $e';
        isLoading = false;
      });
    }
  }

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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Based on your input:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text('📝 Symptoms: ${widget.symptoms}'),
                  Text('⏱️ Duration: ${widget.duration}'),
                  Text(
                      '📋 History: ${widget.history.isEmpty ? 'None' : widget.history}'),
                  const SizedBox(height: 24),
                  const Text(
                    'AI Suggested Causes:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(aiResult ?? 'No result.'),
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

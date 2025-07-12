import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _loading = false;

  Future<void> _submitQuery() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _response = '';
    });

    try {
      final aiReply = await askMedicalQuestion(query);
      setState(() {
        _response = aiReply;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: ${e.toString()}';
        _loading = false;
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Karuna K Saathi',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for any medical issue or ask about symptoms',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'What should I do when...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _submitQuery,
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : _response.isEmpty
                    ? const Text(
                        'Suggestions or chatbot replies will appear here...',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    : Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _response,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

// ✅ Function to call Mistral-7B via Together.ai
Future<String> askMedicalQuestion(String query) async {
  const apiKey = 'a7712f6215a5638026041f084e8c4d22d546dd81c9d656cf43d4119212927e62'; // 🔑 Replace this with your real key
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
              "You are a helpful medical assistant. Give concise, medically accurate, and safe advice for common medical questions or concerns. Always suggest seeing a doctor for serious issues."
        },
        {
          "role": "user",
          "content": query,
        }
      ],
      "temperature": 0.7,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['choices'][0]['message']['content'];
  } else {
    throw Exception('Failed to get AI response: ${response.body}');
  }
}

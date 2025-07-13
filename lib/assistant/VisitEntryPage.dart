import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitEntryPage extends StatefulWidget {
  const VisitEntryPage({super.key});

  @override
  State<VisitEntryPage> createState() => _VisitEntryPageState();
}

class _VisitEntryPageState extends State<VisitEntryPage> {
  List<Map<String, dynamic>> visits = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final String baseUrl = 'http://10.0.2.2:5000/api/visits';

  @override
  void initState() {
    super.initState();
    fetchVisits();
  }

  Future<void> fetchVisits() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          visits = data
              .map((e) => {
                    'id': e['_id'],
                    'patientName': e['patientName'],
                    'description': e['description'],
                    'done': e['done'],
                  })
              .toList();
        });
      } else {
        print('Failed to fetch visits: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching visits: $e');
    }
  }

  Future<void> addVisit(String name, String desc) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'patientName': name,
          'description': desc,
          'done': false,
        }),
      );
      if (response.statusCode == 201) {
        fetchVisits();
      } else {
        print('Failed to add visit: ${response.body}');
      }
    } catch (e) {
      print('Error adding visit: $e');
    }
  }

  Future<void> updateVisitStatus(String id, bool done) async {
    try {
      await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'done': done}),
      );
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void _addNewVisit() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Visit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Visit Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final desc = descController.text.trim();
                  if (name.isNotEmpty && desc.isNotEmpty) {
                    addVisit(name, desc);
                    nameController.clear();
                    descController.clear();
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Add Visit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisitItem(Map<String, dynamic> visit, int index) {
    final isDone = visit['done'] ?? false;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (bool? value) {
            if (value == null) return;
            setState(() {
              visits[index]['done'] = value;
            });
            updateVisitStatus(visit['id'], value);
          },
        ),
        title: Text(
          visit['patientName'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          visit['description'],
          style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        // Removed the trailing icon
        onTap: () {
          // Optional: future expansion
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Today’s Visits',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: visits.isEmpty
          ? const Center(child: Text('No visits logged yet.'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: visits.length,
              itemBuilder: (context, index) {
                return _buildVisitItem(visits[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewVisit,
        backgroundColor: const Color(0xFF3E1F99),
        child: const Icon(Icons.add),
        tooltip: 'Add Visit',
      ),
    );
  }
}

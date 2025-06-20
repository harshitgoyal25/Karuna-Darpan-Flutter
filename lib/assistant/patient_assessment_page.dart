import 'package:flutter/material.dart';

class PatientAssessmentPage extends StatelessWidget {
  const PatientAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Patient Assessment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ListView(
          children: const [
            _SectionTitle('Chief Complaint'),
            SizedBox(height: 6),
            Text('Cancer, Stroke, Chronic, AIDS'),
            SizedBox(height: 20),
            _SectionTitle('Vitals'),
            SizedBox(height: 6),
            Text(
                'BP: 120/80 mmHg\nBody Temp: 98.6°F\nBlood Sugar: 110 mg/dL\nHemoglobin: 13.5 g/dL'),
            SizedBox(height: 20),
            _SectionTitle('Other Complaints'),
            SizedBox(height: 6),
            Text('Pain, Paralysis, General Weakness, Paresthesia'),
            SizedBox(height: 20),
            _SectionTitle('Mobility (Scale 0–4)'),
            SizedBox(height: 6),
            Text(
              '0 = Fully mobile\n1 = With support\n2 = Wheelchair\n3 = Transfer only\n4 = Bedridden',
            ),
            SizedBox(height: 20),
            _SectionTitle('Complications'),
            SizedBox(height: 6),
            Text('Bed sore, UTI'),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

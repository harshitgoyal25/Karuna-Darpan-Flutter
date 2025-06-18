import 'package:flutter/material.dart';

class PatientAssessmentPage extends StatelessWidget {
  const PatientAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Assessment'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text('Chief Complaint', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Cancer Stroke Chronic AIDS'),
            SizedBox(height: 16),
            Text('Vitals', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('BP: 120/80 mmHg Body Temp: 98.6 deg farh Blood sugar: 110 mg/dL Hemoglobin: 13.5 g/dL'),
            SizedBox(height: 16),
            Text('Other Complaints', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('PainParalysisGeneral Weakness Paresthesia'),
            SizedBox(height: 16),
            Text('Mobility (Scale 0–4):', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('0 = Fully mobile,1 = With support, = Wheelchair, 3 = Transfer only, 4 = Bedridden.'),
            SizedBox(height: 16),
            Text('Complications', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Bed sore UTI'),
          ],
        ),
      ),
    );
  }
}
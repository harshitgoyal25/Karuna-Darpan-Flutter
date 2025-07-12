import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqList = [
      {
        'question': '1. What should I do if I have a fever?',
        'answer':
            'If your fever is mild, rest and drink plenty of fluids. Use paracetamol if needed. If it lasts more than 3 days or is very high, visit the nearest health center.'
      },
      {
        'question': '2. How can I prevent common infections?',
        'answer':
            'Wash your hands with soap, drink clean water, use toilets, and eat freshly cooked food to avoid infections.'
      },
      {
        'question': '3. What should pregnant women do for a healthy pregnancy?',
        'answer':
            'Visit the local health center regularly, take iron and calcium tablets, eat nutritious food, and get enough rest.'
      },
      {
        'question': '4. What are signs of dehydration?',
        'answer':
            'Dry mouth, dizziness, less urination, and feeling weak. Drink ORS or salt-sugar water. If very weak, go to a hospital.'
      },
      {
        'question': '5. How to take care of wounds?',
        'answer':
            'Clean with clean water, apply antiseptic if available, and cover with clean cloth. Avoid touching with dirty hands.'
      },
      {
        'question': '6. When should I take my child to the doctor?',
        'answer':
            'If your child has high fever, trouble breathing, diarrhea with weakness, or does not eat or drink well, visit a doctor quickly.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health FAQs', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faq['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'assistant/assistant_page.dart';
import 'assistant/patients_page.dart';
import 'assistant/tasks_page.dart';
import 'assistant/calls_page.dart';
import 'assistant/learning_page.dart';
import 'assistant/performance_page.dart';
import 'assistant/patient_list_page.dart';
import 'assistant/add_patient_page.dart';
import 'assistant/patient_profile_page.dart';
import 'assistant/patient_registration_page.dart';
import 'assistant/patient_assessment_page.dart';
import 'assistant/session_time_page.dart';

void main() => runApp(const KarunaDarpanApp());

class KarunaDarpanApp extends StatelessWidget {
  const KarunaDarpanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karuna Darpan',
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/assistant': (context) => const AssistantPage(),
        '/patients': (context) => const PatientsPage(),
        '/tasks': (context) => const TasksPage(),
        '/calls': (context) => const CallsPage(),
        '/learning': (context) => const LearningPage(),
        '/performance': (context) => const PerformancePage(),
        '/patient-list': (context) => const PatientListPage(),
        '/add-patient': (context) => const AddPatientPage(),
        '/patient-profile': (context) => const PatientProfilePage(),
        '/patient-registration': (context) => const PatientRegistrationPage(),
        '/patient-assessment': (context) => const PatientAssessmentPage(),
        '/session-time': (context) => const SessionTimePage(),
      },
    );
  }
}
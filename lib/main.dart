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
import 'patient/patient_dashboard.dart';
import 'patient/symptom_tracker.dart';
import 'patient/call_for_help.dart';
import 'patient/health_history.dart';
import 'patient/learning_page.dart';
import 'patient/chatbot_page.dart';
import 'assistant/personal_info_page.dart';
import 'admin/admin_dashboard_page.dart';
import 'admin_login.dart';
import 'admin/visit_trend_page.dart';
import 'admin/team_heatmap_page.dart';
import 'admin/resources_page.dart';
import 'admin/high_risk_page.dart';
import 'admin/morphine_stock_page.dart';
import 'admin/referrals_page.dart';
import 'forget_password_page.dart'; // Adjust path if needed
import 'create_account_page.dart';

import 'assistant/add_task_page.dart';

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
        '/patient-dashboard': (context) => const PatientDashboard(),
        '/symptom-tracker': (context) => const SymptomTrackerPage(),
        '/call-for-help': (context) => const CallForHelpPage(),
        '/health-history': (context) => const HealthHistoryPage(),
        '/patient-learning': (context) => const PatientLearningPage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/personal-info': (context) => const PersonalInfoPage(),
        '/admin-dashboard': (context) => const AdminDashboardMainPage(),
        '/admin-login-page': (context) => const AdminLoginPage(),
        '/visit-trends': (context) => const VisitTrendsPage(),
        '/team-heatmap': (context) => const TeamHeatmapPage(),
        '/resources': (context) => const ResourcesPage(),
        '/high-risk': (context) => const HighRiskPage(),
        '/morphine-stock': (context) => const MorphineStockPage(),
        '/referrals': (context) => const ReferralsPage(),
        '/add-task': (context) => const AddTaskPage(),
        '/forget-password': (context) => const ForgetPasswordPage(),
        '/create-account': (context) => const CreateAccountPage(),

      },
    );
  }
}

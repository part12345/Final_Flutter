import 'package:flutter/material.dart';

import 'models/job_application.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

import 'pages/welcome_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/applications_page.dart';
import 'pages/calendar_page.dart';
import 'pages/profile_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JobTrackApp());
}

class JobTrackApp extends StatefulWidget {
  const JobTrackApp({super.key});

  @override
  State<JobTrackApp> createState() => _JobTrackAppState();
}

class _JobTrackAppState extends State<JobTrackApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobTrack',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: WelcomePage(
        onThemeChanged: (value) {
          setState(() {
            darkMode = value;
          });
        },
      ),
    );
  }
}

class JobTrackController extends ChangeNotifier {
  List<JobApplication> applications = [];

  bool darkMode = false;

  bool interviewReminders = true;
  bool applicationReminders = true;
  bool emailNotifications = false;

  Future<void> load() async {
    applications = await StorageService.loadApplications();

    if (applications.isEmpty) {
      applications = _sampleApplications();
      await save();
    }

    notifyListeners();
  }

  Future<void> save() async {
    await StorageService.saveApplications(applications);
    notifyListeners();
  }

  Future<void> addApplication(JobApplication application) async {
    applications.insert(0, application);
    await save();
  }

  Future<void> updateApplication(JobApplication application) async {
    final index = applications.indexWhere(
      (item) => item.id == application.id,
    );

    if (index != -1) {
      applications[index] = application;
      await save();
    }
  }

  Future<void> deleteApplication(String id) async {
    applications.removeWhere(
      (item) => item.id == id,
    );

    await save();
  }

  Future<void> clearAll() async {
    applications.clear();
    await StorageService.clearApplications();
    notifyListeners();
  }

  List<JobApplication> _sampleApplications() {
    return [
      JobApplication(
        id: '1',
        companyName: 'Google',
        jobPosition: 'Frontend Developer',
        location: 'Manila, Philippines',
        jobType: 'Full-time',
        dateApplied: DateTime(2026, 9, 26),
        status: 'Interview',
        expectedSalary: '₱30,000 - ₱40,000',
        jobLink: 'https://careers.google.com',
        notes: 'Technical interview scheduled.',
        interviewDate: DateTime(2026, 9, 26),
        interviewTime: '10:00 AM',
        interviewType: 'Online',
        interviewLink: 'https://meet.google.com',
      ),
      JobApplication(
        id: '2',
        companyName: 'ABC Company',
        jobPosition: 'Graphic Designer',
        location: 'Cebu City, Philippines',
        jobType: 'Full-time',
        dateApplied: DateTime(2026, 9, 24),
        status: 'Applied',
        expectedSalary: '₱25,000 - ₱35,000',
        jobLink: '',
        notes: '',
      ),
      JobApplication(
        id: '3',
        companyName: 'XYZ Inc.',
        jobPosition: 'Backend Developer',
        location: 'Makati, Philippines',
        jobType: 'Full-time',
        dateApplied: DateTime(2026, 9, 20),
        status: 'In Review',
        expectedSalary: '₱35,000 - ₱45,000',
        jobLink: '',
        notes: '',
      ),
      JobApplication(
        id: '4',
        companyName: 'Tech Solutions',
        jobPosition: 'IT Support',
        location: 'Quezon City, Philippines',
        jobType: 'Full-time',
        dateApplied: DateTime(2026, 9, 18),
        status: 'Offer',
        expectedSalary: '₱28,000 - ₱38,000',
        jobLink: '',
        notes: '',
      ),
      JobApplication(
        id: '5',
        companyName: 'Global Corp',
        jobPosition: 'UI/UX Designer',
        location: 'Pasig City, Philippines',
        jobType: 'Full-time',
        dateApplied: DateTime(2026, 9, 15),
        status: 'Rejected',
        expectedSalary: '₱30,000 - ₱40,000',
        jobLink: '',
        notes: '',
      ),
    ];
  }
}

class JobTrackScope extends InheritedNotifier<JobTrackController> {
  const JobTrackScope({
    super.key,
    required JobTrackController controller,
    required Widget child,
  }) : super(
          notifier: controller,
          child: child,
        );

  static JobTrackController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<JobTrackScope>()!
        .notifier!;
  }
}

class MainShell extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const MainShell({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  late JobTrackController controller;

  @override
  void initState() {
    super.initState();

    controller = JobTrackController();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        onNavigate: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      const ApplicationsPage(),
      const CalendarPage(),
      const ProfilePage(),
    ];

    return JobTrackScope(
      controller: controller,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: pages[currentIndex],
        ),
        bottomNavigationBar: NavigationBar(
          height: 68,
          selectedIndex: currentIndex,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primaryLight,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.work_outline),
              selectedIcon: Icon(Icons.work),
              label: 'Applications',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

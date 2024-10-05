import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_map_app/Screens/Dashboard.dart/index.dart';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/index.dart';

final GlobalKey<_MainScreenState> mainScreenKey = GlobalKey<_MainScreenState>();

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: mainScreenKey);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PendingCasesScreen(),
    const AssignedCases(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.newspaper),
            activeIcon: Icon(FontAwesomeIcons.newspaper),
            label: 'New Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            activeIcon: Icon(Icons.assignment_add),
            label: 'Assigned Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF281C9D),
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        selectedLabelStyle: const TextStyle(fontFamily: 'NA'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'NA',fontSize: 10),
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 24),
        type: BottomNavigationBarType.fixed, // Ensures all labels are always visible
      ),
    );
  }
}

class AssignedCases extends StatelessWidget {
  const AssignedCases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Cases', style: TextStyle(fontFamily: 'NA', color: Colors.white)),
        backgroundColor: const Color(0xFF281C9D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text('Assigned Screen', style: TextStyle(fontFamily: 'NA')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:application_about_me/ui/home/widgets/home_screen.dart';
import 'package:application_about_me/ui/github_info/widgets/github_info_screen.dart';

class MainNavigationWidget extends StatefulWidget {
  const MainNavigationWidget({super.key});

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const GitHubScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Резюме',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'GitHub',
          ),
        ],
      ),
    );
  }
}
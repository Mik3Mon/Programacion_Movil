import 'package:flutter/material.dart';
import 'Scenes/Calendar.dart';
import 'Scenes/Counter.dart';
import 'Scenes/Location.dart';
import 'Scenes/Maps.dart';
import 'Scenes/Calculator.dart';
import 'Scenes/Login.dart';
import 'Scenes/Welcome.dart';

class MainNavigator extends StatefulWidget{
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator>{
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  final List<Widget> _screens = [
    const WelcomePage(title: "Welcome"),
    const CounterPage(title: "Counter"),
    const Calculator(title: "Calculator"),
    const LoginScreen(title: "LogIn"),
    const CalendarPage(title: "Calendar"),
    const LocationScreen(title: "Location"),
    const MapScreen(title: "Map")
  ];

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int i){
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload_outlined),
                label: "Cloud",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_outlined),
                label: "Calculator",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.login_outlined),
                label: "LogIn",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: "Calendar",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compass_calibration_outlined),
                label: "Location",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: "Maps",
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.pink,
            selectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'Scenes/Calendar.dart';
import 'Scenes/Counter.dart';
import 'Scenes/Location.dart';
import 'Scenes/Maps.dart';
import 'Scenes/Calculator.dart';
import 'Scenes/Login.dart';
import 'Scenes/Welcome.dart';
import 'Scenes/Charts.dart';
import 'Scenes/NFC.dart';

class MainNavigator extends StatefulWidget{
  const MainNavigator({super.key});
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator>{
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    const WelcomePage(title: "Welcome"),
    const CounterPage(title: "Counter"),
    const Calculator(title: "Calculator"),
    const LoginScreen(title: "LogIn"),
    const CalendarPage(title: "Calendar"),
    const ChartsScreen(title: "Charts"),
    const LocationScreen(title: "Location"),
    const MapScreen(title: "Map"),
    const NFCScreen(title: "NFC"),
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
                icon: Icon(Icons.add_circle_outline),
                label: "Counter Cloud",
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
                icon: Icon(Icons.add_chart_outlined),
                label: "Charts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_searching_outlined),
                label: "Location",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: "Maps",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.nfc_outlined),
                label: "NFC",
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.indigo,
            selectedItemColor: Colors.black,
          ),
        ),
      ),
    );
  }
}


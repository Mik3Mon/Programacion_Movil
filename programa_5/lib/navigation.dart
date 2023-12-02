import 'package:flutter/material.dart';
import 'Scenes/Calculator.dart';
import 'Scenes/UpdateText.dart';
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
    const Calculator(title: "Calculator"),
    const LoginScreen(title: "Update Text"),
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
            children: _screens,
            onPageChanged: _onPageChanged,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(0),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_outlined),
                  label: "Calculator",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.title_outlined),
                  label: "Update Text",
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


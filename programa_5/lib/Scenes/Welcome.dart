import 'package:flutter/material.dart';
import 'dart:math';

class Globals {
  static String variableGlobal = '';
  static String variableGlobal2 = '';
}


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  String _welcomeMessage = '';

  int randomNumber(int  min, int max) {
    return Random().nextInt(max - min) + min;
  }

  Widget welcomeText(int min, int max) {
    int random = randomNumber(min, max);
    if(random == 1){
      _welcomeMessage = 'Welcome Sir';
    } else if(random == 2){
      _welcomeMessage = 'Hello my friend';
    }

    return Text(
        _welcomeMessage,
        style: Theme.of(context).textTheme.headline4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            welcomeText(1, 3),
            Text(
              Globals.variableGlobal,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              Globals.variableGlobal2,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Mangekyou_Sharingan_Itachi.svg/1200px-Mangekyou_Sharingan_Itachi.svg.png',
              width: 250,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
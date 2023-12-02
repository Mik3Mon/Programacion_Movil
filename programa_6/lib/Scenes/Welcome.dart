import 'package:flutter/material.dart';

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
  final String _almacena = "Welcome";

  Widget loginValidation(String password){
    String _text = '';
    if(password == Globals.variableGlobal2){
      _text = Globals.variableGlobal;
    }

    return Text(
      _text,
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
            Text(
              _almacena,
              style: Theme.of(context).textTheme.headline4,
            ),
            loginValidation('FESARAGON'),
          ],
        ),
      ),
    );
  }
}
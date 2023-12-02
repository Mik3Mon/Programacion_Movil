import 'package:flutter/material.dart';
import 'Welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _updateText = '';
  String _updateText2 = '';



  Widget loginButton(String buttonText, Color buttonColor, Color textColor) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: buttonColor
    );

    return ElevatedButton(
      onPressed: (){
        _updateText = _controller1.text;
        _updateText2 = _controller2.text;
        Globals.variableGlobal = _updateText;
        Globals.variableGlobal2 = _updateText2;
      },
      style: raisedButtonStyle,
      child: Text(buttonText,
        style: TextStyle(
          fontSize: 30,
          color: textColor,
        ),
      ),
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
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: _controller1,
                decoration: const InputDecoration(
                    labelText: 'User'
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: _controller2,
                decoration: const InputDecoration(
                    labelText: 'Password'
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: loginButton("Log In", Colors.indigo, Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

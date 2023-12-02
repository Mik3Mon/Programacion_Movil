import 'package:flutter/material.dart';

extension NumberParsing on String {
  double toDouble(){
    return double.parse(this);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programa 4',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Programa 4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _texto = "";
  String _almacena = "";
  double _resultado = 0;
  int _operacion = 0;

  void _realizaOperacion(){
    if(_operacion == 1) {
      _resultado = _almacena.toDouble() + _texto.toDouble();
    }
    else if(_operacion == 2){
      _resultado = _almacena.toDouble() - _texto.toDouble();
    }
    if(_operacion == 3) {
      _resultado = _almacena.toDouble() * _texto.toDouble();
    }
    else if(_operacion == 4){
      _resultado = _almacena.toDouble() / _texto.toDouble();
    }
  }

  void _actualizaAlma() {
    _almacena = _resultado.toString();
  }

  void _incrementCounter(String a) {
    setState(() {
      if(a.codeUnits[0] >= 48 && a.codeUnits[0] <= 57) {
        _texto += a;
      }
      else {
        if(a == "." && !_texto.contains(".")) {
          if(_texto.isNotEmpty){
            _texto += a;
          }
          else {
            _texto += "0";
          }
        }
        if(a == "+"){

        }
      }
    });
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
            Text(
              _texto,
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("1");
                    },
                    child: Text("1", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("2");
                    },
                    child: Text("2", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("3");
                    },
                    child: Text("3", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("+");
                    },
                    child: Text("+", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("4");
                    },
                    child: Text("4", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("5");
                    },
                    child: Text("5", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("6");
                    },
                    child: Text("6", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("-");
                    },
                    child: Text("-", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("7");
                    },
                    child: Text("7", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("8");
                    },
                    child: Text("8", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("9");
                    },
                    child: Text("9", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("x");
                    },
                    child: Text("x", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter(".");
                    },
                    child: Text(".", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("0");
                    },
                    child: Text("0", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("=");
                    },
                    child: Text("=", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      _incrementCounter("/");
                    },
                    child: Text("/", style: Theme.of(context).textTheme.headline4,),
                    backgroundColor: Colors.deepPurple,
                  ),
                ]
            )
          ],
        ),
      ),
    );
  }
}

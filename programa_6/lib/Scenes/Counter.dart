import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget{
  const CounterPage({Key? key, required this.title}): super(key:key);
  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _text = "Button has been pressed";
  int _n = 0;
  
  Future<void> _loadN() async{
    final docRef = db.collection("ElContador").doc("La Variable");
    docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _n = data["contador"];
          });
        },
      onError: (e) => {
          print("Error getting document: $e"),
      }
    );
  }
  
  void _incrementCounter() {
    setState(() {
      _n += 1;
      final docRef = db.doc("ElContador/La Variable");
      docRef.set({"contador":_n});
    });
  }
  
  @override
  void initState(){
    _loadN();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "${_n}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
  
}
import 'package:flutter/material.dart';
import 'package:gastos/data/expense_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async{
  //intialize hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseData(),
        builder: (context , child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Expenses",
          home:HomePage(),
        ),
    );
  }

}


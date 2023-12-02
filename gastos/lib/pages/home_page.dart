import 'package:flutter/material.dart';
import 'package:gastos/components/expense_summarys.dart';
import 'package:gastos/components/expense_tile.dart';
import 'package:gastos/models/expense_item.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  //controlador de texto
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState(){
    super.initState();

    //prepare data on startup
    Provider.of<ExpenseData>(context, listen : false).prepareData();
  }

  //agregar gasto
  void addNewExpense(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title:Text('Add new expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //nombre del gasto
              TextField(
                controller: newExpenseNameController,
                decoration: const InputDecoration(
                  hintText: "Expense name",
                ),
              ),
              //cantidad
              Row(children: [
                //pesos
                Expanded(
                  child:
                    TextField(
                      controller: newExpenseDollarController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Pesos",
                      ),
                    ),
                ),

                //centavos
                Expanded(
                  child:
                    TextField(
                      controller: newExpenseCentsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Centavos",
                      ),
                    ),
                ),
              ],),
            ],
          ),
          actions: [
            //guardar bton
            MaterialButton(
                onPressed: save,
                child: Text('Save'),
            ),
            //cancelar bton
            MaterialButton(
              onPressed: cancel,
              child: Text('Cancel'),
            ),
          ],
        ),
    );
  }

  //delete expense
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }


  //guardar boton
  void save(){
    //put dollar and cents together
    if(newExpenseNameController.text.isNotEmpty
        && newExpenseDollarController.text.isNotEmpty
        &&newExpenseCentsController.text.isNotEmpty) {

      String amount = '${newExpenseDollarController.text}.${newExpenseCentsController.text}';

      //create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    }


    Navigator.pop(context);
  }
  //cancelar boton
  void cancel(){
    Navigator.pop(context);
  }

  //clear controllers
  void clear(){
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context){
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(children: [

            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            const SizedBox(height:20),

            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context,index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),

          ],)
        ),
    );
  }
}
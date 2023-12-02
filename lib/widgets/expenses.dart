import 'package:expensis_app/models/expense.dart';
import 'package:expensis_app/widgets/chart/chart.dart';
import 'package:expensis_app/widgets/expenses_list/expenses_list.dart';
import 'package:expensis_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredData = [
    Expense(
      amount: 19.99,
      date: DateTime.now(),
      title: 'Flutter Course',
      catagory: Catagory.work,
    ),
    Expense(
      amount: 14.50,
      date: DateTime.now(),
      title: 'Cinema',
      catagory: Catagory.leisure,
    ),
  ];

  void _addExpenseSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredData.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredData.indexOf(expense);
    setState(() {
      _registeredData.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredData.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Try to add some!'),
    );

    if (_registeredData.isNotEmpty) {
      mainContent = ExpensesList(_removeExpense, expenses: _registeredData);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses app'), actions: [
        IconButton(
          onPressed: _addExpenseSheet,
          icon: const Icon(Icons.add),
        ),
      ]),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredData),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(children: [
              Expanded(
                child: Chart(expenses: _registeredData),
              ),
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}

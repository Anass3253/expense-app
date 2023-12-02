import 'package:expensis_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenses, {super.key});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(expenses.title, style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('\$${expenses.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Icon(catagoryIcon[expenses.catagory]),
              const SizedBox(
                width: 4,
              ),
              Text(expenses.formattedDate),
            ],
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/expense_model.dart';
import '../pages/add_expense_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../pages/edit_expense_screen.dart';
import 'app_alert_dialog.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseTile({super.key,
    required this.expense});

  @override
  Widget build(BuildContext context) {
    final amountColor = expense.isIncome ? AppColors.green : AppColors.red;


    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left section: Title + Category
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    expense.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Center section: Amount + Time
            SizedBox(
              width: 120,     // fixed width for perfect alignment
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormatter.formatCurrency(expense.amount),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: amountColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 3),
                  Text(
                    DateFormatter.formatDateTime(expense.date),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),


            // Popup menu (3 dots)
            Padding(
              padding: const EdgeInsets.only(left: 45, ),
              child: PopupMenuButton<String>(
                color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.scaffoldBgDark // Dark mode color
                  : Colors.white,
                icon: const Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == 'edit') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditExpenseScreen(expense: expense),
                      ),
                    );
                  }

                  if (value == 'delete') {
                    showDialog(
                      context: context,
                      builder: (ctx) => AppAlertDialog(
                            title: "Delete Expense",
                            message: "Are you sure you want to delete this expense?",
                            confirmText: "Delete",
                            cancelText: "Cancel",
                            onConfirm: () {
                              context.read<ExpenseBloc>().add(DeleteExpense(expense));
                            },
                          ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

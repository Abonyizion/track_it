import 'package:hive/hive.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  static const String boxName = 'expensesBox';

  // Open the Hive box
  Future<Box<ExpenseModel>> _openBox() async {
    return await Hive.openBox<ExpenseModel>(boxName);
  }

  // Add a new expense
  Future<void> addExpense(ExpenseModel expense) async {
    final box = await _openBox();
    await box.add(expense); // Hive assigns its own key
  }

  // Get all expenses
  Future<List<ExpenseModel>> getAllExpenses() async {
    final box = await _openBox();
    final expenses = box.values.toList();

    // Sort by date (oldest first)
    expenses.sort((a, b) => a.date.compareTo(b.date));
    return expenses;
  }

  // Update an existing expense
  Future<void> updateExpense(ExpenseModel expense) async {
    await expense.save(); // no need to open the box
  }

  // Delete an expense
  Future<void> deleteExpense(ExpenseModel expense) async {
    await expense.delete(); // no need to open the box
  }

  // Clear all expenses
  Future<void> clearAllExpenses() async {
    final box = await _openBox();
    await box.clear();
  }
}

import 'package:hive/hive.dart';
import '../models/expense_model.dart';

class ExpenseLocalDataSource {
  Future<Box<ExpenseModel>> _openBox() async {
    return await Hive.openBox<ExpenseModel>('expenses');
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final box = await _openBox();
    await box.add(expense);     // ALWAYS CREATES NEW
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await expense.save();        // UPDATES CORRECT TILE
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    await expense.delete();      // REMOVES CORRECT TILE
  }

  Future<void> clearAllExpenses() async {
    final box = await _openBox();
    await box.clear();
  }
}

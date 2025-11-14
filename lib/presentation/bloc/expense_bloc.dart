import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/expense_repository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository;

  ExpenseBloc({required this.repository}) : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<ClearAllExpenses>(_onClearAllExpenses);
  }

  Future<void> _onLoadExpenses(
      LoadExpenses event,
      Emitter<ExpenseState> emit,
      ) async {
    emit(ExpenseLoading());
    try {
      final expenses = await repository.getAllExpenses();

      double totalIncome = 0;
      double totalExpense = 0;

      for (var e in expenses) {
        if (e.isIncome) {
          totalIncome += e.amount;
        } else {
          totalExpense += e.amount;
        }
      }

      final totalBalance = totalIncome - totalExpense;

      emit(ExpenseLoaded(
        expenses: expenses,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        totalBalance: totalBalance,
      ));
    } catch (e) {
      emit(ExpenseError('Failed to load expenses: $e'));
    }
  }


  Future<void> _onAddExpense(
      AddExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.addExpense(event.expense);
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError('Failed to add expense: $e'));
    }
  }

  Future<void> _onUpdateExpense(
      UpdateExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.updateExpense(event.expense);
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError('Failed to update expense: $e'));
    }
  }

  Future<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) async {
    try {
      await repository.deleteExpense(event.expense); // ✅ now event.expense exists
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError('Failed to delete expense: $e'));
    }
  }

  Future<void> _onClearAllExpenses(
      ClearAllExpenses event,
      Emitter<ExpenseState> emit,
      ) async {
    try {
      await repository.clearAllExpenses();   // you will create this next
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError('Failed to clear expenses: $e'));
    }
  }
}

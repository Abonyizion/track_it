import 'package:equatable/equatable.dart';
import '../../data/models/expense_model.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;
  final double totalIncome;
  final double totalExpense;
  final double totalBalance;

  const ExpenseLoaded({
    required this.expenses,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalBalance,
  });

  @override
  List<Object?> get props => [
    expenses,
    totalIncome,
    totalExpense,
    totalBalance,
  ];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}

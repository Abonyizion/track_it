// blocs/expense_event.dart
import 'package:equatable/equatable.dart';
import '../../data/models/expense_model.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final ExpenseModel expense;

  const AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpense extends ExpenseEvent {
  final ExpenseModel expense;

  const UpdateExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final ExpenseModel expense; // pass the object, not id

  const DeleteExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ClearAllExpenses extends ExpenseEvent {}


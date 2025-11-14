import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 1)
class ExpenseModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  bool isIncome;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  ExpenseModel copyWith({

    String? title,
    double? amount,
    String? category,
    DateTime? date,
    bool? isIncome,
  }) {
    return ExpenseModel(

      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}

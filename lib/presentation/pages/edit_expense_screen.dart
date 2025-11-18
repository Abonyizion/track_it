import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/core/constants/app_colors.dart';
import 'package:track_it/presentation/widgets/custom_button.dart';
import '../../core/constants/general_constants.dart';
import '../../data/models/expense_model.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../widgets/gradient_app_bar.dart';

class EditExpenseScreen extends StatefulWidget {
  final ExpenseModel expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController titleController;
  late TextEditingController categoryController;
  late TextEditingController amountController;
  late DateTime selectedDate;
  late bool isIncome;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    titleController = TextEditingController(text: widget.expense.title);
    categoryController = TextEditingController(text: widget.expense.category);
    amountController = TextEditingController(text: widget.expense.amount.toString());
    selectedDate = widget.expense.date;
    isIncome = expense.isIncome;
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      barrierColor: Theme.of(context).brightness == Brightness.dark
        ? AppColors.scaffoldBgDark // Dark mode color
        : Colors.white24,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void saveChanges() {
    widget.expense.title = titleController.text.trim();
    widget.expense.category = categoryController.text.trim();
    widget.expense.amount = double.tryParse(amountController.text.trim()) ?? 0;
    widget.expense.date = selectedDate;
    widget.expense.isIncome = isIncome;

    // This updates the existing Hive object
    context.read<ExpenseBloc>().add(UpdateExpense(widget.expense));

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyGradientAppBar(
          title: widget.expense.isIncome ? "Edit Income" : "Edit Expense",
      ),
      body: Padding(
        padding: GeneralConstants.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 22),
              const Text("Title",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                  height: 6),
              _roundedInputField(
                  controller: titleController),

              const SizedBox(
                  height: 16),
              const Text("Category",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                  height: 6),

              _roundedInputField(
                  controller: categoryController),

              const SizedBox(
                  height: 16),
              const Text("Amount",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                  height: 6),
              _roundedInputField(
                  controller: amountController,
              keyboardType: TextInputType.number,
              ),

              const SizedBox(
                  height: 27),
              InkWell(
                onTap: pickDate,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900  // dark mode border
                          : AppColors.lightGrey,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textDark.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                      style: TextStyle(
                          fontSize: 16),),
                      const Icon(
                          Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height: 50),

              CustomButton(
                text: "Save Changes",
                onTap: saveChanges,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Rounded input field
  Widget _roundedInputField({
    required TextEditingController controller,
    String? hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900  // dark mode border
              : AppColors.lightGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

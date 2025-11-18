
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/core/constants/app_colors.dart';
import 'package:track_it/presentation/widgets/custom_button.dart';
import 'package:track_it/presentation/widgets/gradient_app_bar.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/general_constants.dart';
import '../../data/models/expense_model.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';


class AddExpenseScreen extends StatefulWidget {
  final ExpenseModel? expense;
  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedCategory = 'Food';

  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Bills',
    'Other',
  ];
      //state variables
      String? _titleError;
      String? _amountError;

  void _submit() {
    setState(() {
      _titleError = _titleController.text.isEmpty ? 'Enter expense name' : null;
      _amountError = _amountController.text.isEmpty ? 'Enter an amount' : null;

      if (_amountError == null) {
        final parsedAmount = double.tryParse(_amountController.text);
        if (parsedAmount == null) {
          _amountError = "Enter a valid number";
        }
      }
    });

    if (_titleError == null && _amountError == null) {
      final expense = ExpenseModel(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        date: DateTime.now().toUtc(),
        isIncome: false,
      );

      context.read<ExpenseBloc>().add(AddExpense(expense));
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyGradientAppBar(
          title: "Add Expense"),
      body: Padding(
        padding: GeneralConstants.scaffoldPadding,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    height: 20),
                const Text("Expense Name",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                    height: 6),
                _roundedInputField(
                  controller: _titleController,
                  hint: "E.g: Groceries, Dinner, Bills etc.",
                  errorText: _titleError,
                ),
                const SizedBox(
                    height: 18),
            
                const Text("Amount",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                    height: 6),
                _roundedInputField(
                  controller: _amountController,
                  hint: "\$ 0.00",
                  keyboardType: TextInputType.number,
                  errorText: _amountError,
                ),
                const SizedBox(
                    height: 18),
                const Text("Category",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                    height: 6),

                _roundedDropdown(),

                const SizedBox(height: 50),

                CustomButton(
                    text: "Add Expense",
                    onTap: _submit,
                  width: double.infinity,
                 // borderRadius: 16,
                 // color: Colors.purple
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Rounded input field
  Widget _roundedInputField({
    required TextEditingController controller,
    String? hint,
    String? errorText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade900
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
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              hintText: hint,
              hintStyle: TextStyle(fontSize: 12, color: AppColors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ]
      ],
    );
  }



// Rounded dropdown
  Widget _roundedDropdown() {
    return Container(
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
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            dropdownColor: Theme.of(context).cardColor,
            items: _categories
                .map((cat) => DropdownMenuItem(
              value: cat,
              child: Text(
                cat,
                style: const TextStyle(fontSize: 14),
              ),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
        ),
      ),
    );
  }


}

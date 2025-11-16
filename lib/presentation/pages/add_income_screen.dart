
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


class AddIncomeScreen extends StatefulWidget {
  final ExpenseModel? expense;
  const AddIncomeScreen({super.key, this.expense});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedCategory = 'Salary';

  final List<String> _categories = [
    'Salary',
    'Transportation',
    'Utilities',
    'Entertainment',
    'Shopping',
    'Health',
    'Others',
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final expense = ExpenseModel(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        date: DateTime.now().toUtc(),
        isIncome: true,
      );

      context.read<ExpenseBloc>().add(AddExpense(expense));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyGradientAppBar(
          title: "Add Income"),
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
                const Text("Source",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                    height: 6),
                _roundedInputField(
                  controller: _titleController,
                  hint: "Examples: Salary, Business, Gifts etc.)",
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter a title' : null,
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
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter an amount' : null,
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
                  text: "Add Income",
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

// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/pages/add_income_screen.dart';
import 'package:track_it/presentation/pages/settings_screen.dart';
import 'package:track_it/presentation/widgets/gradient_app_bar.dart';
import 'package:track_it/presentation/widgets/summary_card.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/general_constants.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';
import '../widgets/app_alert_dialog.dart';
import '../widgets/expense_tile.dart';
import 'add_expense_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger loading immediately
    context.read<ExpenseBloc>().add(LoadExpenses());
  }

  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }



  @override
  Widget build(BuildContext context) {
    //  Use the existing global ExpenseBloc from main.dart
   // final bloc = context.read<ExpenseBloc>();
    return Scaffold(
      appBar: MyGradientAppBar(
          title: "Dashboard",
        padding: const EdgeInsets.only(left: 12),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
              icon: Icon(Icons.settings),
          ),
        )
      ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            final income = state.totalIncome;
            final expense = state.totalExpense;
            final balance = state.totalBalance;
            final expenses = state.expenses;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: GeneralConstants.scaffoldPadding,
                  child: SummaryCard(
                    title: "Total Balance",
                      amount: balance,
                      bgColor: AppColors.softBlue,
                      icon: null,
                    isVisible: _isVisible,
                    showIcon: true,
                    onToggleVisibility: _toggleVisibility,
                    iconColor: null,
                    centerText: true,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: SummaryCard(title: "Total Income",
                            amount: income,
                            icon: Icons.arrow_downward,
                          iconColor: AppColors.green,
                        bgColor: AppColors.lightGreen,
                          isVisible: _isVisible,
                          showIcon: false,
                         // icon: Icons.arrow_upward,
                        iconBgColor: AppColors.arrowBackgroundGreen,
                        ),
                      ),
                      SizedBox(
                          width: 12),
                      Expanded(
                        child: SummaryCard(title: "Total Expense",
                            amount: expense,
                            icon: Icons.arrow_upward,
                          iconColor: AppColors.red,
                        bgColor: AppColors.lightRed,
                            isVisible: _isVisible,
                            showIcon: false,
                        iconBgColor: AppColors.arrowBackgroundRed),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AppAlertDialog(
                              title: "Clear All",
                              message: "Are you sure you want to clear all expense?",
                              confirmText: "Clear",
                              cancelText: "Cancel",
                              onConfirm: () {
                                context.read<ExpenseBloc>().add(ClearAllExpenses());
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          height: 22,
                          width: 60,
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: expenses.isEmpty
                      ? const Center(
                    child: Text(
                      'No expenses added yet.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ExpenseTile(expense: expense);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ExpenseError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 26, right: 12),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.blue,
                AppColors.green,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(27),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: AppColors.transparent,
              child: SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: AppColors.transparent, // Use the gradient instead
               // overlayColor: Colors.black,
                overlayOpacity: 0.35,
                elevation: 1.0,
                spacing: 10,
                spaceBetweenChildren: 8,
                children: [
                  SpeedDialChild(
                    child: const Icon(
                        Icons.remove_circle,
                        size: 20,
                        color: AppColors.white),
                    backgroundColor: Colors.red.shade300,
                    label: 'Add Expense',
                    shape: CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddExpenseScreen(),
                        ),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.add_circle,
                        size: 20,
                        color: AppColors.white),
                    backgroundColor: Colors.green.shade300,
                    label: 'Add Income',
                    shape: CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddIncomeScreen(),
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

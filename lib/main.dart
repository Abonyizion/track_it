import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_theme.dart';
import 'data/models/expense_model.dart';
import 'data/repositories/expense_repository.dart';
import 'data/services/theme_service.dart';
import 'presentation/bloc/expense_bloc.dart';
import 'presentation/bloc/theme/theme_cubit.dart';
import 'presentation/pages/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive and open boxes
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('expensesBox');

  // Load saved theme
  final isDarkMode = await ThemeService.loadTheme();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>(
          create: (_) => ExpenseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ExpenseBloc>(
            create: (context) => ExpenseBloc(
              repository: context.read<ExpenseRepository>(),
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(isDarkMode),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Track It',
          theme: AppTheme.lightTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.light().textTheme,
            ),
          ),
          darkTheme: AppTheme.darkTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.dark().textTheme,
            ),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const OnboardingScreen(),
        );
      },
    );
  }
}

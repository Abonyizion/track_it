import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/theme_service.dart';

class ThemeCubit extends Cubit<bool> {
  // true = dark mode, false = light mode
  ThemeCubit(bool initialTheme) : super(initialTheme);

  void toggleTheme(bool isDarkMode) {
    emit(isDarkMode);
    ThemeService.saveTheme(isDarkMode);
  }
}

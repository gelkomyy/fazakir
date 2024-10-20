import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the theme state
enum ThemeState { light, dark }

// Create the ThemeCubit
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light) {
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) safeEmit(ThemeState.dark);
  }

  void toggleTheme() {
    final newState =
        state == ThemeState.light ? ThemeState.dark : ThemeState.light;
    safeEmit(newState);
  }
}

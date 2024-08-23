import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);
  final Set<int> _navigationStack = {0}; // Initialize with index 0
  navigationIndexView(int index) {
    if (_navigationStack.isNotEmpty && index != _navigationStack.last) {
      // Add new index to stack only if it's different from the last index
      _navigationStack.add(index);
    }
    if (index == 0) {
      resetToHome();
    }
    safeEmit(index);
  }

  void backNavigation() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeWhere(
          (index) => index == _navigationStack.last); // Remove current index
      final previousIndex = _navigationStack.last; // Get the previous index
      safeEmit(previousIndex);
    }
  }

  void resetToHome() {
    _navigationStack.clear();
    _navigationStack.add(0); // Reset stack to only include index 0
    emit(0);
  }
}

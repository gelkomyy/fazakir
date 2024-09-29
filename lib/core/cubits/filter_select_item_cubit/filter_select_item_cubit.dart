import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSelectItemCubit extends Cubit<Map<String, String>> {
  FilterSelectItemCubit() : super({});

  void setSelectedItem(String selectedItem, String key) {
    safeEmit({...state, key: selectedItem});
  }
}
